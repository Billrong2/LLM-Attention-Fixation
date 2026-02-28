use std::collections::HashMap;

fn f(dic: HashMap<isize, String>) -> HashMap<String, isize> {
    let dic2: HashMap<String, isize> = dic.into_iter().map(|(k, v)| (v, k)).collect();
    dic2
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(-1, String::from("a")), (0, String::from("b")), (1, String::from("c"))])), HashMap::from([(String::from("a"), -1), (String::from("b"), 0), (String::from("c"), 1)]));
}
