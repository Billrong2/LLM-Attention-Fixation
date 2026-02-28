fn f(text: String) -> isize {
    let mut text = text.to_uppercase();
    let mut count_upper = 0;
    
    for char in text.chars() {
        if char.is_ascii_uppercase() {
            count_upper += 1;
        } else {
            return "no".parse().unwrap();
        }
    }
    
    return count_upper / 2;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ax")), 1);
}
