fn f(text: String) -> String {
    let length = text.len();
    let mut index = 0;
    while index < length && text.chars().nth(index).unwrap().is_whitespace() {
        index += 1;
    }
    text[index..index+5].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("-----	
	th
-----")), String::from("-----"));
}
