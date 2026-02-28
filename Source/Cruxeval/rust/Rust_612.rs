use std::collections::HashMap;

fn f(d: HashMap<String, isize>) -> HashMap<String, isize> {
    d.clone()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("a"), 42), (String::from("b"), 1337), (String::from("c"), -1), (String::from("d"), 5)])), HashMap::from([(String::from("a"), 42), (String::from("b"), 1337), (String::from("c"), -1), (String::from("d"), 5)]));
}
