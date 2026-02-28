use std::collections::HashMap;

fn f(dict: HashMap<isize, String>) -> Vec<isize> {
    let mut even_keys = Vec::new();
    for key in dict.keys() {
        if key % 2 == 0 {
            even_keys.push(*key);
        }
    }
    even_keys
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(4, String::from("a"))])), vec![4]);
}
