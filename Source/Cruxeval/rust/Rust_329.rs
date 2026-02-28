fn f(text: String) -> bool {
    for i in 1..text.len() {
        if text.chars().nth(i) == Some(text.chars().nth(i).unwrap().to_uppercase().to_string().chars().next().unwrap()) && text.chars().nth(i-1) == Some(text.chars().nth(i-1).unwrap().to_lowercase().to_string().chars().next().unwrap()) {
            return true;
        }
    }
    false
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jh54kkk6")), true);
}
