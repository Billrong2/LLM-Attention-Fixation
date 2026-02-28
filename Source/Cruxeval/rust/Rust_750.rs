use std::collections::HashMap;

fn f(char_map: HashMap<String, String>, text: String) -> String {
    let mut new_text = String::new();
    for ch in text.chars() {
        let val = char_map.get(&ch.to_string());
        match val {
            Some(v) => new_text.push_str(v),
            None => new_text.push(ch),
        }
    }
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([]), String::from("hbd")), String::from("hbd"));
}
