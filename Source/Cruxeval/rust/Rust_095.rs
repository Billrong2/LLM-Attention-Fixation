use std::collections::HashMap;

fn f(zoo: HashMap<String, String>) -> HashMap<String, String> {
    zoo.into_iter().map(|(k, v)| (v, k)).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("AAA"), String::from("fr"))])), HashMap::from([(String::from("fr"), String::from("AAA"))]));
}
