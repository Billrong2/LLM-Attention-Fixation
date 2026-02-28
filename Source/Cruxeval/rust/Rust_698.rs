fn f(text: String) -> String {
    text.chars().filter(|&x| x != ')').collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("(((((((((((d))))))))).))))(((((")), String::from("(((((((((((d.((((("));
}
