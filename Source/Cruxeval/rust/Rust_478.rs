use std::collections::HashMap;

fn f(sb: String) -> HashMap<String, isize> {
    let mut d = HashMap::new();
    for s in sb.chars() {
        let counter = d.entry(s.to_string()).or_insert(0);
        *counter += 1;
    }
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("meow meow")), HashMap::from([(String::from("m"), 2), (String::from("e"), 2), (String::from("o"), 2), (String::from("w"), 2), (String::from(" "), 1)]));
}
