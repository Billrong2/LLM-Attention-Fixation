fn f(text: String) -> bool {
    let mut b = true;
    for x in text.chars() {
        if x.is_numeric() {
            b = true;
        } else {
            b = false;
            break;
        }
    }
    b
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("-1-3")), false);
}
