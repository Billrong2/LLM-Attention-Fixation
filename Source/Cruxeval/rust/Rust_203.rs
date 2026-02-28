use std::collections::HashMap;

fn f(mut d: HashMap<String, String>) -> HashMap<String, String> {
    d.clear();
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("a"), String::from("3")), (String::from("b"), String::from("-1")), (String::from("c"), String::from("Dum"))])), HashMap::from([]));
}
