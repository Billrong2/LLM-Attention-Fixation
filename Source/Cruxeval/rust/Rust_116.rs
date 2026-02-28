use std::collections::HashMap;

fn f(mut d: HashMap<isize, isize>, count: isize) -> HashMap<isize, isize> {
    for _ in 0..count {
        if d.is_empty() {
            break;
        }
        if let Some(key) = d.keys().next().cloned() {
            d.remove(&key);
        }
    }
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([]), 200), HashMap::from([]));
}
