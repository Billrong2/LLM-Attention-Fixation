fn f(text: String, value: String) -> String {
    let mut indexes: Vec<usize> = Vec::new();
    for (i, c) in text.chars().enumerate() {
        if c.to_string() == value && (i == 0 || text.chars().nth(i - 1).unwrap().to_string() != value) {
            indexes.push(i);
        }
    }
    
    if indexes.len() % 2 == 1 {
        return text;
    }
    
    return text[indexes[0] + 1..indexes[indexes.len() - 1]].to_string();
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("btrburger"), String::from("b")), String::from("tr"));
}
