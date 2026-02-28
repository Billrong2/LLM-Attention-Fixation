fn f(sentence: String) -> bool {
    for c in sentence.chars() {
        if !c.is_ascii() {
            return false;
        } else {
            continue;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("1z1z1")), true);
}
