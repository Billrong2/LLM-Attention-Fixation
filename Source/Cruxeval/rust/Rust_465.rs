use std::collections::HashMap;

fn f(seq: Vec<String>, value: String) -> HashMap<String, String> {
    let mut roles = seq.iter().map(|s| (s.clone(), String::from("north"))).collect::<HashMap<_, _>>();
    if !value.is_empty() {
        for key in value.split(", ") {
            roles.insert(key.trim().to_string(), String::from("north"));
        }
    }
    roles
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("wise king"), String::from("young king")], String::from("")), HashMap::from([(String::from("wise king"), String::from("north")), (String::from("young king"), String::from("north"))]));
}
