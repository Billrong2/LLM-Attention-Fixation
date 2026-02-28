fn f(text: String, old: String, new: String) -> String {
    if old.len() > 3 {
        return text;
    }
    if text.contains(&old) && !text.contains(' ') {
        return text.replace(&old, &new.repeat(old.len()));
    }
    let mut result = text.clone();
    while result.contains(&old) {
        result = result.replace(&old, &new);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("avacado"), String::from("va"), String::from("-")), String::from("a--cado"));
}
