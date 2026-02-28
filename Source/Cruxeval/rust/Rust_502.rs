fn f(name: String) -> String {
    name.replace(' ', "*")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Fred Smith")), String::from("Fred*Smith"));
}
