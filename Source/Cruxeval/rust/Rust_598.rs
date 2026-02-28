fn f(text: String, n: isize) -> String {
    let length = text.len();
    text.chars().skip(length * (n % 4) as usize).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abc"), 1), String::from(""));
}
