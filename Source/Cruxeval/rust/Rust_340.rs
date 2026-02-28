fn f(text: String) -> String {
    let uppercase_index = text.find('A');
    if let Some(idx) = uppercase_index {
        return text[..idx].to_string() + &text[text.find('a').unwrap_or(0) + 1..];
    } else {
        let mut sorted_chars: Vec<char> = text.chars().collect();
        sorted_chars.sort();
        return sorted_chars.into_iter().collect();
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("E jIkx HtDpV G")), String::from("   DEGHIVjkptx"));
}
