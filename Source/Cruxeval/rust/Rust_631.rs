use std::iter::Repeat;

fn f(text: String, num: usize) -> String {
    let req = num - text.len();
    let mut padding = String::from("*").repeat(req as usize / 2);
    padding.push_str(&text);
    padding.push_str(&String::from("*").repeat(req as usize / 2));
    padding[req..num].chars().collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a"), 19), String::from("*"));
}
