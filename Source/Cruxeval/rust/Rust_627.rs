use std::collections::HashMap;

fn f(parts: Vec<(String, isize)>) -> Vec<isize> {
    let parts_hash: HashMap<String, isize> = parts.into_iter().collect();
    let values: Vec<isize> = parts_hash.values().cloned().collect();
    values
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![(String::from("u"), 1), (String::from("s"), 7), (String::from("u"), -5)]), vec![-5, 7]);
}
