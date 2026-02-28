use std::collections::HashMap;

fn f(commands: Vec<HashMap<String, isize>>) -> HashMap<String, isize> {
    let mut d: HashMap<String, isize> = HashMap::new();
    
    for c in commands {
        for (key, value) in c {
            d.insert(key, value);
        }
    }
    
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![HashMap::from([(String::from("brown"), 2)]), HashMap::from([(String::from("blue"), 5)]), HashMap::from([(String::from("bright"), 4)])]), HashMap::from([(String::from("brown"), 2), (String::from("blue"), 5), (String::from("bright"), 4)]));
}
