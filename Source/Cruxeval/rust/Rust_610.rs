use std::collections::HashMap;

fn f(keys: Vec<isize>, value: isize) -> HashMap<isize, isize> {
    let mut map = HashMap::new();
    for &key in &keys {
        map.insert(key, value);
    }
    for (i, &key) in keys.iter().enumerate() {
        let i = i as isize + 1;
        if let (Some(&v1), Some(&v2)) = (map.get(&i), map.get(&key)) {
            if v1 == v2 {
                map.remove(&i);
            }
        }
    }
    map
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 1, 1], 3), HashMap::from([]));
}
