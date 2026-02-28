use std::collections::HashMap;

fn f(s: String) -> HashMap<String, isize> {
    let mut count: HashMap<String, isize> = HashMap::new();
    for i in s.chars() {
        if i.is_lowercase() {
            let key = i.to_string();
            count.insert(key.clone(), s.matches(&key).count() as isize + count.get(&key).cloned().unwrap_or(0));
        } else {
            let key = i.to_lowercase().to_string();
            count.insert(key.clone(), s.matches(&i.to_uppercase().to_string()).count() as isize + count.get(&key).cloned().unwrap_or(0));
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("FSA")), HashMap::from([(String::from("f"), 1), (String::from("s"), 1), (String::from("a"), 1)]));
}
