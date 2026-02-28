fn f(val: String, text: String) -> isize {
    let indices: Vec<usize> = text.chars().enumerate().filter(|(_, c)| *c == val.chars().nth(0).unwrap()).map(|(i, _)| i).collect();
    if indices.is_empty() {
        return -1;
    } else {
        return indices[0] as isize;
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("o"), String::from("fnmart")), -1);
}
