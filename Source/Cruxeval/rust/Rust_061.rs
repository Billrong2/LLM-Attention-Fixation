fn f(text: String) -> String {
    let texts: Vec<&str> = text.split_whitespace().collect();
    if !texts.is_empty() {
        let xtexts: Vec<&str> = texts.iter().filter(|&t| t.is_ascii() && *t != "nada" && *t != "0").cloned().collect();
        if !xtexts.is_empty() {
            xtexts.iter().max_by_key(|t| t.len()).unwrap_or(&"nada").to_string()
        } else {
            "nada".to_string()
        }
    } else {
        "nada".to_string()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("")), String::from("nada"));
}
