use std::collections::HashMap;

fn f(text: String) -> HashMap<String, isize> {
    let mut dic = HashMap::new();
    
    for char in text.chars() {
        let count = dic.entry(char.to_string()).or_insert(0);
        *count += 1;
    }
    
    for (_, value) in dic.iter_mut() {
        if *value > 1 {
            *value = 1;
        }
    }
    
    dic
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a")), HashMap::from([(String::from("a"), 1)]));
}
