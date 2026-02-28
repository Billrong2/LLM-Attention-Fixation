use std::collections::HashMap;

fn f(dct: HashMap<String, isize>) -> Vec<(String, isize)> {
    let mut lst: Vec<(String, isize)> = Vec::new();
    let mut keys: Vec<&String> = dct.keys().collect();
    keys.sort();
    for key in keys {
        lst.push((key.clone(), dct[key]));
    }
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("a"), 1), (String::from("b"), 2), (String::from("c"), 3)])), vec![(String::from("a"), 1), (String::from("b"), 2), (String::from("c"), 3)]);
}
