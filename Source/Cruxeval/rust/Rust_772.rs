fn f(phrase: String) -> String {
    let mut result = String::new();
    for i in phrase.chars() {
        if !i.is_lowercase() {
            result.push(i);
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("serjgpoDFdbcA.")), String::from("DFA."));
}
