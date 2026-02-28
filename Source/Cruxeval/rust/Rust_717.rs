fn f(text: String) -> String {
    let text = text.chars().collect::<Vec<char>>();
    let (mut k, mut l) = (0, text.len() - 1);
    while !text[l].is_alphanumeric() {
        l -= 1;
    }
    while !text[k].is_alphanumeric() {
        k += 1;
    }
    if k != 0 || l != text.len() - 1 {
        return text[k..=l].iter().collect();
    } else {
        return text[0].to_string();
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("timetable, 2mil")), String::from("t"));
}
