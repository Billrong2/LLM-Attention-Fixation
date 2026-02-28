fn f(text: String) -> bool {
    !text.chars().any(|c| c.is_uppercase())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("lunabotics")), true);
}
