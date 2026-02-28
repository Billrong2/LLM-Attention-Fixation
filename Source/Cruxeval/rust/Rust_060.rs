fn f(doc: String) -> String {
    for x in doc.chars() {
        if x.is_alphabetic() {
            return x.to_uppercase().to_string();
        }
    }
    "-".to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("raruwa")), String::from("R"));
}
