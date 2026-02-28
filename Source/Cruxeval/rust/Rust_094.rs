use std::collections::HashMap;

fn f(a: HashMap<String, isize>, b: HashMap<String, isize>) -> HashMap<String, isize> {
    let mut result = a.clone();
    result.extend(b);
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("w"), 5), (String::from("wi"), 10)]), HashMap::from([(String::from("w"), 3)])), HashMap::from([(String::from("w"), 3), (String::from("wi"), 10)]));
}
