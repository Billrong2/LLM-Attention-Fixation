fn f(number: String) -> bool {
    number.chars().all(char::is_numeric)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dummy33;d")), false);
}
