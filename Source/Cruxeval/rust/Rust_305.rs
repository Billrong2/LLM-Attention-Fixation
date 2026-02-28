fn f(text: String, char: String) -> String {
    let mut index = -1;
    for (i, c) in text.chars().enumerate() {
        if c.to_string() == char {
            index = i as isize;
        }
    }

    if index == -1 {
        index = (text.len() / 2) as isize;
    }

    let mut new_text: Vec<char> = text.chars().collect();
    new_text.remove(index as usize);
    new_text.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("o horseto"), String::from("r")), String::from("o hoseto"));
}
