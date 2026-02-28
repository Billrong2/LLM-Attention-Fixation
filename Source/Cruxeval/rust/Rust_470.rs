fn f(number: isize) -> Vec<String> {
    let transl = vec![('A', 1), ('B', 2), ('C', 3), ('D', 4), ('E', 5)];
    let mut result = Vec::new();
    for (key, value) in &transl {
        if value % number == 0 {
            result.push(key.to_string());
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(2), vec![String::from("B"), String::from("D")]);
}
