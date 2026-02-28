fn f(text: String) -> String {
    let mut text_list = text.chars().collect::<Vec<char>>();
    for i in 0..text_list.len() {
        text_list[i] = if text_list[i].is_lowercase() {
            text_list[i].to_ascii_uppercase()
        } else {
            text_list[i].to_ascii_lowercase()
        };
    }
    text_list.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("akA?riu")), String::from("AKa?RIU"));
}
