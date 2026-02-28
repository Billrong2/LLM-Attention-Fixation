fn f(text: String) -> String {
    let s = text.to_lowercase();
    for i in 0..s.len() {
        if s.chars().nth(i).unwrap() == 'x' {
            return String::from("no");
        }
    }
    text.to_uppercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dEXE")), String::from("no"));
}
