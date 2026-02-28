fn f(text: String, n: isize) -> String {
    if text.len() as isize <= 2 {
        return text;
    }
    let leading_chars = text.chars().next().unwrap().to_string().repeat(n as usize - text.len() + 1);
    leading_chars + &text[1..text.len()-1] + &text[text.len()-1..]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("g"), 15), String::from("g"));
}
