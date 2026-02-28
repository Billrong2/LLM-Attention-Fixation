use std::collections::HashMap;

fn f(mut ets: HashMap<isize, isize>) -> HashMap<isize, isize> {
    while !ets.is_empty() {
        let (k, v) = ets.drain().next().unwrap();
        ets.insert(k, v * v);
    }
    ets
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), HashMap::from([]));
}
