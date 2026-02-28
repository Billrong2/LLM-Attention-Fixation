fn f(text: String) -> String {
    if text.is_empty() {
        return text;
    }
    if text.chars().all(|c| c.is_uppercase()) {
        text.to_lowercase()
    } else {
        text[..3].to_lowercase()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n")), String::from("mty"));
}
