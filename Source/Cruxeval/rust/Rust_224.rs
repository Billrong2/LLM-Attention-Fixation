use std::collections::HashMap;

fn f(array: Vec<String>, value: isize) -> HashMap<String, isize> {
    let mut array = array;
    array.reverse();
    array.pop();
    let mut odd: Vec<HashMap<String, isize>> = vec![];
    while let Some(item) = array.pop() {
        let mut tmp = HashMap::new();
        tmp.insert(item, value);
        odd.push(tmp);
    }
    let mut result = HashMap::new();
    while let Some(odd_item) = odd.pop() {
        result.extend(odd_item);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("23")], 123), HashMap::from([]));
}
