fn f(text: String, size: isize) -> String {
    let mut counter = text.len();
    let mut text = text;
    for i in 0..(size - (size % 2) as isize) {
        text = format!(" {} ", text);
        counter += 2;
        if counter >= size as usize {
            return text;
        }
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("7"), 10), String::from("     7     "));
}
