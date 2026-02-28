fn f(t: String) -> bool {
    for c in t.chars() {
        if !c.is_numeric() {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("#284376598")), false);
}
