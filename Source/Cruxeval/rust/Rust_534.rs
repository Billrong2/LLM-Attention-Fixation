fn f(sequence: String, value: String) -> String {
    let mut i = std::cmp::max(sequence.find(&value).unwrap_or(0) as isize - sequence.len() as isize / 3, 0) as usize;
    let mut result = String::new();
    for (j, v) in sequence[i..].chars().enumerate() {
        if v == '+' {
            result.push_str(&value);
        } else {
            result.push(sequence.chars().nth(i + j).unwrap());
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hosu"), String::from("o")), String::from("hosu"));
}
