use std::collections::HashMap;

fn f(fields: (String, String, String), update_dict: HashMap<String, String>) -> HashMap<String, String> {
    let mut di = HashMap::new();
    di.insert(fields.0.clone(), "".to_string());
    di.insert(fields.1.clone(), "".to_string());
    di.insert(fields.2.clone(), "".to_string());
    di.extend(update_dict);
    di
}

fn main() {
    let candidate = f;
    assert_eq!(candidate((String::from("ct"), String::from("c"), String::from("ca")), HashMap::from([(String::from("ca"), String::from("cx"))])), HashMap::from([(String::from("ct"), String::from("")), (String::from("c"), String::from("")), (String::from("ca"), String::from("cx"))]));
}
