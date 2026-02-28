fn f(text: String, splitter: String) -> String {
    let lower_text: String = text.to_lowercase();
    let words: Vec<&str> = lower_text.split_whitespace().collect();
    words.join(&splitter)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("LlTHH sAfLAPkPhtsWP"), String::from("#")), String::from("llthh#saflapkphtswp"));
}
