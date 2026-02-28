fn f(text: String, char: String) -> Vec<isize> {
    let mut new_text = text.clone();
    let mut a: Vec<isize> = Vec::new();
    while new_text.contains(&char) {
        a.push(new_text.find(&char).unwrap() as isize);
        new_text = new_text.replacen(&char, "", 1);
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("rvr"), String::from("r")), vec![0, 1]);
}
