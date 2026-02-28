use std::collections::HashMap;

fn f(d: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let mut d = d;
    let key1 = *d.iter().max_by_key(|x| x.0).unwrap().0;
    let val1 = d.remove(&key1).unwrap();
    let key2 = *d.iter().max_by_key(|x| x.0).unwrap().0;
    let val2 = d.remove(&key2).unwrap();
    let mut result = HashMap::new();
    result.insert(key1, val1);
    result.insert(key2, val2);
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(2, 3), (17, 3), (16, 6), (18, 6), (87, 7)])), HashMap::from([(87, 7), (18, 6)]));
}
