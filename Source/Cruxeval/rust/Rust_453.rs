fn f(string: String, c: String) -> bool {
    string.ends_with(&c)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wrsch)xjmb8"), String::from("c")), false);
}
