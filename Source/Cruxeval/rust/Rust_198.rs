fn f(text: String, strip_chars: String) -> String {
    text.chars().rev().collect::<String>().trim_matches(|c| strip_chars.contains(c)).chars().rev().collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("tcmfsmj"), String::from("cfj")), String::from("tcmfsm"));
}
