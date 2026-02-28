use std::collections::HashMap;

fn f(mut d: HashMap<isize, isize>, index: isize) -> isize {
    let length = d.len();
    let idx = index as usize % length;
    let mut iter = d.into_iter();
    for _ in 0..idx {
        iter.next().unwrap();
    }
    let (_, v) = iter.next().unwrap();
    v
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(27, 39)]), 1), 39);
}
