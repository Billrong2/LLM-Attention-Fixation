use std::iter::repeat;

fn f(text: String, limit: usize, char: String) -> String {
    if limit < text.len() {
        return text[0..limit].to_string();
    }
    let pad_size = limit - text.len();
    let padding = repeat(char.chars().next().unwrap()).take(pad_size).collect::<String>();
    format!("{}{}", text, padding)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("tqzym"), 5, String::from("c")), String::from("tqzym"));
}
