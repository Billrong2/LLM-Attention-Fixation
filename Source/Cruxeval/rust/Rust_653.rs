fn f(text: String, letter: String) -> isize {
    let mut t = text.clone();
    for alph in text.chars() {
        t = t.replace(alph, "");
    }
    t.split(&letter).count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("c, c, c ,c, c"), String::from("c")), 1);
}
