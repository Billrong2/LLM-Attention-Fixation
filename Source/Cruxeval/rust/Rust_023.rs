fn f(text: String, chars: String) -> String {
    let mut strip_chars: Vec<char> = chars.chars().collect();
    if strip_chars.is_empty() {
        strip_chars.push(' ');
    }
    let mut result = text.chars().collect::<Vec<char>>();
    while let Some(&last_char) = result.last() {
        if !strip_chars.contains(&last_char) {
            break;
        }
        result.pop();
    }
    if result.is_empty() {
        return String::from("-");
    }
    result.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("new-medium-performing-application - XQuery 2.2"), String::from("0123456789-")), String::from("new-medium-performing-application - XQuery 2."));
}
