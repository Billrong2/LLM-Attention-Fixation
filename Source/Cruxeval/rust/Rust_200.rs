fn f(text: String, value: String) -> String {
    let mut value = value;
    let mut length = text.len();
    let mut index = 0;
    while length > 0 {
        value = format!("{}{}", &text[index..index + 1], value);
        length -= 1;
        index += 1;
    }
    value
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jao mt"), String::from("house")), String::from("tm oajhouse"));
}
