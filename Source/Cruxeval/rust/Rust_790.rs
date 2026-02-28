use std::collections::HashMap;

fn f(d: HashMap<String, String>) -> (bool, bool) {
    let r = HashMap::from([
        ("c".to_string(), d.clone()),
        ("d".to_string(), d.clone()),
    ]);
    (std::ptr::eq(&r["c"], &r["d"]), r["c"] == r["d"])
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("i"), String::from("1")), (String::from("love"), String::from("parakeets"))])), (false, true));
}
