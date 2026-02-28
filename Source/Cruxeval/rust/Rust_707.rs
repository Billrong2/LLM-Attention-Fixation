fn f(text: String, position: isize) -> String {
    let length = text.len();
    let index = position % (length as isize + 1);
    let mut index = if position < 0 || index < 0 { -1 } else { index };
    let mut new_text = text.chars().collect::<Vec<char>>();
    new_text.remove(index as usize);
    new_text.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("undbs l"), 1), String::from("udbs l"));
}
