use std::collections::HashMap;

fn f(d: HashMap<String, isize>, l: Vec<String>) -> HashMap<String, isize> {
    let mut new_d: HashMap<String, isize> = HashMap::new();

    for k in l {
        if let Some(v) = d.get(&k) {
            new_d.insert(k.clone(), *v);
        }
    }

    new_d.clone()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("lorem ipsum"), 12), (String::from("dolor"), 23)]), vec![String::from("lorem ipsum"), String::from("dolor")]), HashMap::from([(String::from("lorem ipsum"), 12), (String::from("dolor"), 23)]));
}
