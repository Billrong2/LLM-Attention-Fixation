use std::collections::HashMap;

fn f(dic: HashMap<String, isize>) -> Vec<(String, isize)> {
    let mut vec: Vec<_> = dic.into_iter().collect();
    vec.sort_by(|a, b| a.0.cmp(&b.0));
    vec
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("b"), 1), (String::from("a"), 2)])), vec![(String::from("a"), 2), (String::from("b"), 1)]);
}
