fn f(input_string: String, spaces: usize) -> String {
    input_string
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a\tb"), 4), String::from("a\tb"));
}
