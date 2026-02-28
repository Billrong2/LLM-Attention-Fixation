fn f(text: String) -> Vec<String> {
    let mut new_text = vec![];
    for i in 0..text.len() / 3 {
        new_text.push(format!("< {} level={} >", &text[i * 3..i * 3 + 3], i));
    }
    let last_item = &text[text.len() / 3 * 3..];
    new_text.push(format!("< {} level={} >", last_item, text.len() / 3));
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("C7")), vec![String::from("< C7 level=0 >")]);
}
