fn f(text: String, mut value: String) -> String {
    let length = text.len();
    let letters: Vec<char> = text.chars().collect();
    if !letters.contains(&value.chars().next().unwrap()) {
        value = letters[0].to_string();
    }
    return value.repeat(length);
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ldebgp o"), String::from("o")), String::from("oooooooo"));
}
