fn f(text: String, prefix: String) -> String {
    let mut text = text;
    if text.starts_with(&prefix) {
        text.replace_range(..prefix.len(), "");
    }
    text = text.to_lowercase();
    if let Some(c) = text.get_mut(0..1) {
        c.make_ascii_uppercase();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("qdhstudentamxupuihbuztn"), String::from("jdm")), String::from("Qdhstudentamxupuihbuztn"));
}
