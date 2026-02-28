fn f(text: String) -> String {
    if text.to_uppercase() == text {
        return String::from("ALL UPPERCASE");
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hello Is It MyClass")), String::from("Hello Is It MyClass"));
}
