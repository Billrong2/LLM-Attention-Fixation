fn f(s: String) -> bool {
    let mut l: Vec<char> = s.chars().collect();
    for i in 0..l.len() {
        l[i] = l[i].to_lowercase().to_string().chars().next().unwrap();
        if !l[i].is_digit(10) {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("")), true);
}
