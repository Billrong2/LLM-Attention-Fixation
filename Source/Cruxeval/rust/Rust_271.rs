fn f(text: String, c: String) -> String {
    let mut ls: Vec<char> = text.chars().collect();
    if !text.contains(&c) {
        panic!(format!("Text has no {}", c));
    }
    ls.remove(text.rfind(&c).unwrap());
    ls.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("uufhl"), String::from("l")), String::from("uufh"));
}
