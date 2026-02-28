fn f(text: String) -> String {
    let mut index = 1;
    let mut chars = text.chars().collect::<Vec<char>>();
    while index < chars.len() {
        if chars[index] != chars[index - 1] {
            index += 1;
        } else {
            let (text1, text2) = chars.split_at(index);
            let text2 = text2.iter().map(|c| if c.is_uppercase() { c.to_ascii_lowercase() } else { c.to_ascii_uppercase() }).collect::<String>();
            return text1.iter().collect::<String>() + &text2;
        }
    }
    text.chars().map(|c| if c.is_uppercase() { c.to_ascii_lowercase() } else { c.to_ascii_uppercase() }).collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("USaR")), String::from("usAr"));
}
