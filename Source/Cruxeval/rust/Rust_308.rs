use std::collections::HashMap;

fn f(strings: Vec<String>) -> HashMap<String, isize> {
    let mut occurrences = HashMap::new();
    for string in strings {
        let count = occurrences.entry(string).or_insert(0);
        *count += 1;
    }
    occurrences
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("La"), String::from("Q"), String::from("9"), String::from("La"), String::from("La")]), HashMap::from([(String::from("La"), 3), (String::from("Q"), 1), (String::from("9"), 1)]));
}
