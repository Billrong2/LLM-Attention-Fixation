fn f(text: String) -> String {
    let mut i = (text.len() + 1) / 2;
    let mut result: Vec<char> = text.chars().collect();
    while i < text.len() {
        let t = result[i].to_lowercase().next().unwrap_or(result[i]);
        if t == result[i] {
            i += 1;
        } else {
            result[i] = t;
        }
        i += 2;
    }
    result.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mJkLbn")), String::from("mJklbn"));
}
