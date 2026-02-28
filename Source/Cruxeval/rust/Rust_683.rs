use std::collections::HashMap;

fn f(dict1: HashMap<String, isize>, dict2: HashMap<String, isize>) -> HashMap<String, isize> {
    let mut result = dict1.clone();
    for (key, value) in dict2.iter() {
        result.insert(key.clone(), *value);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("disface"), 9), (String::from("cam"), 7)]), HashMap::from([(String::from("mforce"), 5)])), HashMap::from([(String::from("disface"), 9), (String::from("cam"), 7), (String::from("mforce"), 5)]));
}
