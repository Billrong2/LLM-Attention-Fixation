fn f(text: String, new_value: String, index: isize) -> String {
    let key = text.chars().nth(index as usize).unwrap();
    let value = new_value.chars().nth(0).unwrap();
    text.replace(key, value.to_string().as_str())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("spain"), String::from("b"), 4), String::from("spaib"));
}
