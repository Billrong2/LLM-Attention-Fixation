fn f(text: String) -> isize {
    let parts: Vec<&str> = text.split(',').collect();
    let string_a = parts[0];
    let string_b = parts[1];
    -((string_a.len() + string_b.len()) as isize)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dog,cat")), -6);
}
