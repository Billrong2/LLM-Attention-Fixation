use std::collections::HashMap;

fn f(array: HashMap<isize, isize>, elem: isize) -> HashMap<isize, isize> {
    let mut result = array.clone();
    while !result.is_empty() {
        let (key, value) = result.drain().next().unwrap();
        if elem == key || elem == value {
            result = array.clone();
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([]), 1), HashMap::from([]));
}
