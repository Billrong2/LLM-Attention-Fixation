fn f(text: String, characters: String) -> String {
    let mut text = text.clone();
    for i in 0..characters.len() {
        text = text.trim_end_matches(characters.chars().nth(i).unwrap()).to_string();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("r;r;r;r;r;r;r;r;r"), String::from("x.r")), String::from("r;r;r;r;r;r;r;r;"));
}
