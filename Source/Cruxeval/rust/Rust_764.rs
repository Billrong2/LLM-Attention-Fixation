fn f(text: String, old: String, new: String) -> String {
    let mut text2 = text.replace(&old, &new);
    let old2 = old.chars().rev().collect::<String>();
    while text2.contains(&old2) {
        text2 = text2.replace(&old2, &new);
    }
    text2
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("some test string"), String::from("some"), String::from("any")), String::from("any test string"));
}
