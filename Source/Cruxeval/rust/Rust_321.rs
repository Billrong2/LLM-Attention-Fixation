use std::collections::HashMap;

fn f(update: HashMap<String, isize>, starting: HashMap<String, isize>) -> HashMap<String, isize> {
    let mut d = starting.clone();
    for (k, v) in update.iter() {
        if let Some(val) = d.get_mut(k) {
            *val += v;
        } else {
            d.insert(k.clone(), *v);
        }
    }
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([]), HashMap::from([(String::from("desciduous"), 2)])), HashMap::from([(String::from("desciduous"), 2)]));
}
