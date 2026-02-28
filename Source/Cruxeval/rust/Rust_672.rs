fn f(text: String, position: isize, value: String) -> String {
    let length = text.len();
    let index = (position % (length as isize + 2)) - 1;
    if index >= length as isize || index < 0 {
        return text;
    }
    let mut text_list: Vec<char> = text.chars().collect();
    text_list[index as usize] = value.chars().next().unwrap();
    text_list.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("1zd"), 0, String::from("m")), String::from("1zd"));
}
