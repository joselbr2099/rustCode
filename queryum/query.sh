GROQ_API_KEY='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'


while true; do
  read -p '>>> ' QRY
  curl --silent -X POST "https://api.groq.com/openai/v1/chat/completions" \
       -H "Authorization: Bearer $GROQ_API_KEY" \
       -H "Content-Type: application/json" \
       -d "{\"messages\": [{\"role\": \"user\", \"content\": \"$QRY\"}], \"model\": \"llama3-70b-8192\"}" \
       | jq -r '.choices[0].message.content' \
       | glow -s dracula
done
