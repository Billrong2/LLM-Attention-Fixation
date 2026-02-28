use std::collections::HashMap;

fn f(dictionary: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let mut a = dictionary.clone();
    let keys_to_delete: Vec<isize> = a.keys().cloned().filter(|&key| key % 2 != 0).collect();
    for key in keys_to_delete {
        a.remove(&key);
        a.insert(key, a[&key]);
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), HashMap::from([]));
}
