fn f(text: String, n: isize) -> String {
    if n < 0 || text.len() as isize <= n {
        return text;
    }
    let result = &text[0..n as usize];
    let mut i = result.len() - 1;
    while i >= 0 {
        if result.chars().nth(i) != text.chars().nth(i) {
            break;
        }
        i -= 1;
    }
    return text[0..=i].to_string();
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bR"), -1), String::from("bR"));
}
