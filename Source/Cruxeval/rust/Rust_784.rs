use std::collections::HashMap;

fn f(key: String, value: String) -> (String, String) {
    let mut dict_: HashMap<String, String> = HashMap::new();
    dict_.insert(key, value);
    let popped = dict_.drain().next().unwrap();
    (popped.0, popped.1)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("read"), String::from("Is")), (String::from("read"), String::from("Is")));
}
