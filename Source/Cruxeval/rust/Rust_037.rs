fn f(text: String) -> Vec<String> {
    let mut text_arr: Vec<String> = Vec::new();
    for j in 0..text.len() {
        text_arr.push(text[j..].to_string());
    }
    text_arr
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("123")), vec![String::from("123"), String::from("23"), String::from("3")]);
}
