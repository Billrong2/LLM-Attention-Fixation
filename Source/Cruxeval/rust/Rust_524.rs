use std::collections::HashMap;

fn f(mut dict0: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let new = dict0.clone();
    let mut sorted_keys: Vec<isize> = new.keys().cloned().collect();
    sorted_keys.sort();
    for i in 0..sorted_keys.len()-1 {
        dict0.insert(sorted_keys[i], i as isize);
    }
    dict0
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(2, 5), (4, 1), (3, 5), (1, 3), (5, 1)])), HashMap::from([(2, 1), (4, 3), (3, 2), (1, 0), (5, 1)]));
}
