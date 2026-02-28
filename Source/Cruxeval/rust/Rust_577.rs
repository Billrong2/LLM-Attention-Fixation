use std::collections::HashMap;

fn f(items: Vec<(isize, String)>) -> Vec<HashMap<isize, String>> {
    let mut result = Vec::new();
    let mut items: HashMap<isize, String> = items.into_iter().collect();

    for _ in 0..items.len() {
        let mut d = items.clone();
        d.remove(&items.keys().nth(0).unwrap());
        result.push(d.clone()); // Clone d before pushing it into the result vector
        items = d;
    }

    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![(1, String::from("pos"))]), vec![HashMap::from([])]);
}
