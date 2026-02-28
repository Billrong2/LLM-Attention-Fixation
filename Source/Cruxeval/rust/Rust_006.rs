use std::collections::HashMap;

fn f(dic: HashMap<String, isize>) -> Vec<(String, isize)> {
    let mut dic: Vec<(String, isize)> = dic.into_iter().collect();
    dic.sort_by_key(|&(ref k, _)| k.len());
    dic.drain(..dic.len()-1);
    dic
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("11"), 52), (String::from("65"), 34), (String::from("a"), 12), (String::from("4"), 52), (String::from("74"), 31)])), vec![(String::from("74"), 31)]);
}
