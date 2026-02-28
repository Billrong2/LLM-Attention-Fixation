use std::collections::HashMap;

fn f(dict: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let mut result = dict.clone();
    let mut remove_keys = vec![];
    for (k, v) in dict.iter() {
        if dict.contains_key(&v) {
            remove_keys.push(*k);
        }
    }
    for k in remove_keys {
        result.remove(&k);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(-1, -1), (5, 5), (3, 6), (-4, -4)])), HashMap::from([(3, 6)]));
}
