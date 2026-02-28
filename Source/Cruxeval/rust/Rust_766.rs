use std::collections::HashMap;

fn f(values: Vec<String>, value: isize) -> HashMap<String, isize> {
    let mut new_dict = HashMap::new();
    let length = values.len();
    
    for val in &values {
        new_dict.insert(val.clone(), value);
    }
    
    let sorted_key = values.iter().cloned().collect::<Vec<String>>().join("");
    new_dict.insert(sorted_key, value * 3);
    
    new_dict
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("0"), String::from("3")], 117), HashMap::from([(String::from("0"), 117), (String::from("3"), 117), (String::from("03"), 351)]));
}
