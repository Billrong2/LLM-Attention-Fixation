fn f(text: String) -> String {
    let mut result = String::new();
    for c in text.chars() {
        if c.is_alphanumeric() {
            result.push(c.to_uppercase().next().unwrap());
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("с bishop.Swift")), String::from("СBISHOPSWIFT"));
}
