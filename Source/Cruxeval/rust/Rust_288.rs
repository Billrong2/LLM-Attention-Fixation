use std::collections::HashMap;

fn f(d: HashMap<isize, isize>) -> Vec<(isize, isize)> {
    let mut sorted_pairs: Vec<(isize, isize)> = d.iter().map(|(k, v)| (*k, *v)).collect();
    sorted_pairs.sort_by_key(|(k, v)| format!("{}{}", k, v).len());
    sorted_pairs.into_iter().filter(|(k, v)| k < v).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(55, 4), (4, 555), (1, 3), (99, 21), (499, 4), (71, 7), (12, 6)])), vec![(1, 3), (4, 555)]);
}
