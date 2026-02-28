fn f(sentences: String) -> String {
    if sentences.split('.').all(|sentence| sentence.parse::<f64>().is_ok()) {
        "oscillating".to_string()
    } else {
        "not oscillating".to_string()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("not numbers")), String::from("not oscillating"));
}
