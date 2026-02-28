use std::collections::HashMap;

fn f(mut a: Vec<String>, b: Vec<isize>) -> Vec<isize> {
    let d: HashMap<_, _> = a.iter().cloned().zip(b.iter().cloned()).collect();
    a.sort_by_key(|k| -d[k]);
    a.into_iter().map(|k| *d.get(&k).unwrap()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("12"), String::from("ab")], vec![2, 2]), vec![2, 2]);
}
