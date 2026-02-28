fn f(string: String) -> bool {
    string.to_uppercase() == string
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Ohno")), false);
}
