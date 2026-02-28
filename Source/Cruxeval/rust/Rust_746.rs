use std::collections::HashMap;

fn f(dct: HashMap<String, String>) -> HashMap<String, String> {
    use std::collections::HashMap;

    let values = dct.values();
    let mut result = HashMap::new();

    for value in values {
        let item = format!("{}@pinc.uk", value.split('.').next().unwrap());
        result.insert(value.clone(), item);
    }

    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), HashMap::from([]));
}
