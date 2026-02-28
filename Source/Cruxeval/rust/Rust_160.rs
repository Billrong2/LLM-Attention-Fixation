use std::collections::HashMap;

fn f(dictionary: HashMap<isize, isize>) -> HashMap<isize, isize> {
    if !dictionary.contains_key(&1) {
        return HashMap::new();
    }
    return dictionary;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(1, 47698), (1, 32849), (1, 38381), (3, 83607)])), HashMap::from([(1, 38381), (3, 83607)]));
}
