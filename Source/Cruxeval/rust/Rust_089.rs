fn f(char: String) -> String {
    if !['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'].contains(&char.chars().next().unwrap()) {
        return "".to_string();
    }
    if ['A', 'E', 'I', 'O', 'U'].contains(&char.chars().next().unwrap()) {
        return char.to_lowercase().to_string();
    }
    char.to_uppercase().to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("o")), String::from("O"));
}
