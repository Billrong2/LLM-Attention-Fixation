use std::collections::HashMap;

fn f(char_freq: HashMap<String, isize>) -> HashMap<String, isize> {
    let mut result: HashMap<String, isize> = HashMap::new();
    for (k, v) in char_freq.clone() {
        result.insert(k, v / 2);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("u"), 20), (String::from("v"), 5), (String::from("b"), 7), (String::from("w"), 3), (String::from("x"), 3)])), HashMap::from([(String::from("u"), 10), (String::from("v"), 2), (String::from("b"), 3), (String::from("w"), 1), (String::from("x"), 1)]));
}
