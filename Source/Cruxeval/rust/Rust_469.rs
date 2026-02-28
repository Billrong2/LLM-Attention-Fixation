fn f(text: String, position: isize, value: String) -> String {
    let length = text.len();
    let index = position as usize % length;
    let mut new_text: Vec<char> = text.chars().collect();
    if position < 0 {
        new_text.insert(length / 2, value.chars().nth(0).unwrap());
        new_text.remove(length - 1);
    } else {
        new_text.insert(index, value.chars().nth(0).unwrap());
        new_text.remove(length - 1);
    }
    new_text.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("sduyai"), 1, String::from("y")), String::from("syduyi"));
}
