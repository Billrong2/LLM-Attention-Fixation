fn f(text: String, elem: String) -> Vec<String> {
    let mut text = text;
    let mut elem = elem;
    
    if elem != "" {
        while text.starts_with(&elem) {
            text = text.replace(&elem, "");
        }
        while elem.starts_with(&text) {
            elem = elem.replace(&text, "");
        }
    }
    
    vec![elem, text]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("some"), String::from("1")), vec![String::from("1"), String::from("some")]);
}
