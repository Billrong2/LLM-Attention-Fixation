fn f(s: String, x: String) -> String {
    let mut count = 0;
    let mut result = s.clone(); // Create a mutable copy of the input string
    
    while result.starts_with(&x) && count < result.len() - x.len() {
        result = result[x.len()..].to_string(); // Update the mutable copy
        count += x.len();
    }
    
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("If you want to live a happy life! Daniel"), String::from("Daniel")), String::from("If you want to live a happy life! Daniel"));
}
