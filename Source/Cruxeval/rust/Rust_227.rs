fn f(text: String) -> String {
    let text = text.to_lowercase();
    let (head, tail) = text.split_at(1);
    return head.to_uppercase() + tail;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Manolo")), String::from("Manolo"));
}
