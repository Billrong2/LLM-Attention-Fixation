fn f(integer: isize, n: isize) -> String {
    let mut i = 1;
    let mut text = integer.to_string();
    while i + text.len() < n as usize {
        i += text.len();
    }
    text.insert_str(0, &"0".repeat(i));
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(8999, 2), String::from("08999"));
}
