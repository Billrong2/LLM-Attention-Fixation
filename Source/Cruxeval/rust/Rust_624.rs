fn f(text: String, char: String) -> String {
    let char_index = text.find(&char).unwrap_or(0);
    let mut result: Vec<char> = text.chars().collect();
    if char_index > 0 {
        result.drain(char_index..text.len());
    }
    result.insert(0, char.chars().collect::<Vec<char>>()[0]);
    result.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("llomnrpc"), String::from("x")), String::from("xllomnrpc"));
}
