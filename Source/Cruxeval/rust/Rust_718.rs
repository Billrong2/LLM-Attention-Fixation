fn f(text: String) -> String {
    let t = text.clone();
    let mut new_text = text.clone();
    for c in text.chars() {
        new_text = new_text.replace(c, "");
    }
    let len = new_text.len();
    format!("{}{}", len, t)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ThisIsSoAtrocious")), String::from("0ThisIsSoAtrocious"));
}
