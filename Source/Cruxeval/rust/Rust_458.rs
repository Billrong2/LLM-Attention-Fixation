use std::collections::HashMap;

fn f(text: String, search_chars: String, replace_chars: String) -> String {
    let trans_table: HashMap<_, _> = search_chars.chars().zip(replace_chars.chars()).collect();
    text.chars().map(|c| *trans_table.get(&c).unwrap_or(&c)).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mmm34mIm"), String::from("mm3"), String::from(",po")), String::from("pppo4pIp"));
}
