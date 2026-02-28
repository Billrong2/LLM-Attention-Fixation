fn f(text: String) -> String {
    let mut result = String::new();
    for i in (0..text.len()).rev() {
        result.push(text.chars().nth(i).unwrap());
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("was,")), String::from(",saw"));
}
