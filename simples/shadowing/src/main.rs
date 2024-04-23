fn main() {
    // Original integer variable declaration
    let x = 42;
    println!("x: {}", x);
    
    // Variable reassignment (shadowing) within the same scope
    let x = "forty-two";
    println!("x: {}", x);
    
    {
        // Creating a nested scope where 'x' has a new binding
        let x = 42.5;
        println!("x: {}", x);
        
        // Leaving the inner scope - original bindings restored
    }
}
