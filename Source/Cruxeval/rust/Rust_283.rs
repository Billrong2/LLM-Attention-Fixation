use std::collections::HashMap;

fn f(mut dictionary: HashMap<String, isize>, mut key: String) -> String {
    dictionary.remove(&key);
    if let Some(min_key) = dictionary.keys().min() {
        if min_key == &key {
            key = dictionary.keys().next().unwrap().clone();
        }
    }
    key.clone()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("Iron Man"), 4), (String::from("Captain America"), 3), (String::from("Black Panther"), 0), (String::from("Thor"), 1), (String::from("Ant-Man"), 6)]), String::from("Iron Man")), String::from("Iron Man"));
}
