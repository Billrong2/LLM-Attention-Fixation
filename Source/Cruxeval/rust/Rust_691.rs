use std::iter::FromIterator;

fn f(text: String, suffix: String) -> String {
    if !suffix.is_empty() {
        let last_char = suffix.chars().last().unwrap();
        if text.contains(last_char) {
            return f(text.trim_end_matches(last_char).to_string(), suffix[0..suffix.len()-1].to_string());
        }
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("rpyttc"), String::from("cyt")), String::from("rpytt"));
}
