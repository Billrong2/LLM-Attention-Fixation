fn f(text: String) -> bool {
    let endings = vec!['.', '!', '?'];
    for i in endings {
        if text.ends_with(i) {
            return true;
        }
    }
    false
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(". C.")), true);
}
