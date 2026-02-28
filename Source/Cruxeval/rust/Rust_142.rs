fn f(x: String) -> String {
    if x.chars().all(|c| c.is_lowercase()) {
        x
    } else {
        x.chars().rev().collect()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ykdfhp")), String::from("ykdfhp"));
}
