fn f(text: String, delim: String) -> String {
    text[..text.chars().rev().position(|c| c == delim.chars().next().unwrap()).unwrap()].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dsj osq wi w"), String::from(" ")), String::from("d"));
}
