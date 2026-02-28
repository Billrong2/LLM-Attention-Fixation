use std::collections::HashMap;

fn f(obj: HashMap<String, isize>) -> HashMap<String, isize> {
    let mut result = obj.clone();
    for (k, v) in &mut result {
        if *v >= 0 {
            *v = -*v;
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("R"), 0), (String::from("T"), 3), (String::from("F"), -6), (String::from("K"), 0)])), HashMap::from([(String::from("R"), 0), (String::from("T"), -3), (String::from("F"), -6), (String::from("K"), 0)]));
}
