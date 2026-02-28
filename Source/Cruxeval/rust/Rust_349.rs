use std::collections::HashMap;

fn f(mut dictionary: HashMap<String, isize>) -> HashMap<String, isize> {
    dictionary.insert(String::from("1049"), 55);
    if let Some((key, value)) = dictionary.clone().into_iter().last() {
        dictionary.remove(&key);
        dictionary.insert(key, value);
    }
    dictionary
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("noeohqhk"), 623)])), HashMap::from([(String::from("noeohqhk"), 623), (String::from("1049"), 55)]));
}
