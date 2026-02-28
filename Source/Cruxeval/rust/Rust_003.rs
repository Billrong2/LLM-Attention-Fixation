fn f(text: String, value: String) -> String {
    let mut text_list: Vec<char> = text.chars().collect();
    text_list.append(&mut value.chars().collect());
    text_list.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bcksrut"), String::from("q")), String::from("bcksrutq"));
}
