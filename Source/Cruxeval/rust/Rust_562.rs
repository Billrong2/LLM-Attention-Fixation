fn f(text: String) -> bool {
    text.to_uppercase() == text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("VTBAEPJSLGAHINS")), true);
}
