use std::collections::HashMap;

fn f(concat: String, mut di: HashMap<String, String>) -> String {
    let count = di.len();
    for i in 0..count {
        if di.contains_key(&i.to_string()) && concat.contains(di[&i.to_string()].as_str()) {
            di.remove(&i.to_string());
        }
    }
    "Done!".to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mid"), HashMap::from([(String::from("0"), String::from("q")), (String::from("1"), String::from("f")), (String::from("2"), String::from("w")), (String::from("3"), String::from("i"))])), String::from("Done!"));
}
