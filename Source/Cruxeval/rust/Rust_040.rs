fn f(text: String) -> String {
    text.chars().chain(std::iter::once('#')).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("the cow goes moo")), String::from("the cow goes moo#"));
}
