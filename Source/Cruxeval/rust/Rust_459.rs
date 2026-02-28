use std::collections::HashMap;

fn f(arr: Vec<String>, mut d: HashMap<String, String>) -> HashMap<String, String> {
    for i in (1..arr.len()).step_by(2) {
        d.insert(arr[i].clone(), arr[i-1].clone());
    }

    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("b"), String::from("vzjmc"), String::from("f"), String::from("ae"), String::from("0")], HashMap::from([])), HashMap::from([(String::from("vzjmc"), String::from("b")), (String::from("ae"), String::from("f"))]));
}
