fn f(text: String, speaker: String) -> String {
    let mut text = text;
    while text.starts_with(&speaker) {
        text = text[speaker.len()..].to_string();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]"), String::from("[CHARRUNNERS]")), String::from("Do you know who the other was? [NEGMENDS]"));
}
