use std::collections::HashMap;

fn f(line: String, equalityMap: Vec<(String, String)>) -> String {
    let map: HashMap<char, char> = equalityMap.iter().map(|(a, b)| (a.chars().next().unwrap(), b.chars().next().unwrap())).collect();
    line.chars().map(|c| match map.get(&c) {
        Some(&new_c) => new_c,
        None => c,
    }).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abab"), vec![(String::from("a"), String::from("b")), (String::from("b"), String::from("a"))]), String::from("baba"));
}
