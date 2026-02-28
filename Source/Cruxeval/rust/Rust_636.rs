use std::collections::HashMap;

fn f(mut d: HashMap<isize, String>) -> HashMap<isize, String> {
    let mut r: HashMap<isize, String> = HashMap::new();
    while !d.is_empty() {
        let max_key = *d.keys().max().unwrap();
        r.extend(d.clone());
        d.remove(&max_key);
    }
    r
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(3, String::from("A3")), (1, String::from("A1")), (2, String::from("A2"))])), HashMap::from([(3, String::from("A3")), (1, String::from("A1")), (2, String::from("A2"))]));
}
