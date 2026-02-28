use std::collections::HashMap;

fn f(dic: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let mut d: HashMap<isize, isize> = HashMap::new();
    let mut it = dic.into_iter();
    while let Some((key, val)) = it.next() {
        d.insert(key, val);
    }
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), HashMap::from([]));
}
