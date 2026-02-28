fn f(text: String, dng: String) -> String {
    if !text.contains(&dng) {
        return text;
    }
    if text.ends_with(&dng) {
        return text[..text.len()-dng.len()].to_string();
    }
    return text[..text.len()-1].to_string() + &f(text[..text.len()-2].to_string(), dng);
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("catNG"), String::from("NG")), String::from("cat"));
}
