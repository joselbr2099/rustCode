#!/bin/env bash

# constante para definir la api key
#GROQ_API_KEY=
MODEL="llama3-70b-8192"
ROLE="user"

#spinner para mostrar el progreso del query
spinner() {                                                                                                       
  local delay=0.75                                                                                                
  local spinstr='|/-\'                                                                                            
  local temp                                                                                                      
  while true; do                                                                                                  
    temp=${spinstr#?}                                                                                             
    printf "  [%c]  " "${temp}"                                                                                    
    spinstr=${temp}${spinstr%%?}                                                                                  
    sleep $delay                                                                                                  
    printf "\b\b\b\b\b\b"                                                                                         
  done                                                                                                            
}

#funcion principal
main(){

  #variables locales
  local QUERY=""
  local JSON_DATA
 
  #recorrido para unir todas las cadenas de entrada
  for arg in "$@"; do 
    QUERY+=" $arg"
  done

  #se formatea los caracteres especiales
  QUERY="$(echo $QUERY | jq -Rs .)" 

  #se inicia el spinner
  spinner &                                                                                                         
  _spinner_pid=$! 
 
  #se preparan los datos de envio
  JSON_DATA='
  {
    "messages": [
        {
            "role": "'$ROLE'",
            "content": '$QUERY'
        },
        {
            "role": "system",
            "content": "You are an expert developer, your name is NEO"
        }
    ],
    "model": "'$MODEL'",
    "temperature": 1,
    "max_tokens": 1024,
    "top_p":1,
    "stream": false,
    "stop":"None"
  }'

  curl --silent -X POST "https://api.groq.com/openai/v1/chat/completions" \
       -H "Authorization: Bearer $GROQ_API_KEY" \
       -H "Content-Type: application/json" \
       -d "$JSON_DATA" \
       #| jq -r '.choices[0].message.content' \
       #| glow -s dracula

  kill ${_spinner_pid}                                                                                              
}

main $@
