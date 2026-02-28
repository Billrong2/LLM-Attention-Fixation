use std::collections::HashMap;

fn f(d: HashMap<isize, isize>, k: isize) -> HashMap<isize, isize> {
    let mut new_d = HashMap::new();
    for (key, val) in d.iter() {
        if *key < k {
            new_d.insert(*key, *val);
        }
    }
    new_d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(1, 2), (2, 4), (3, 3)]), 3), HashMap::from([(1, 2), (2, 4)]));
}
