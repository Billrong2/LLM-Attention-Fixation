use std::collections::HashMap;

fn f(dic: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let mut dic_op = dic.clone();
    for (key, val) in &dic {
        dic_op.insert(*key, val * val);
    }
    dic_op
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(1, 1), (2, 2), (3, 3)])), HashMap::from([(1, 1), (2, 4), (3, 9)]));
}
