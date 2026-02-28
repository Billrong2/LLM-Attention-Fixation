fn f(text: String, suffix: String) -> String {
    if text.ends_with(&suffix) {
        let mut result = text.clone();
        let len = result.len();
        result = result[..len-1].to_string() + &result[len-1..].chars().next().unwrap().to_uppercase().to_string();
        result
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("damdrodm"), String::from("m")), String::from("damdrodM"));
}
