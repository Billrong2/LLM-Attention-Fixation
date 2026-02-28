use std::collections::HashMap;

fn f(aDict: HashMap<isize, isize>) -> HashMap<isize, isize> {
    aDict.into_iter().map(|(k, v)| (v, k)).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(1, 1), (2, 2), (3, 3)])), HashMap::from([(1, 1), (2, 2), (3, 3)]));
}
