fn f(text: String, fill: String, mut size: isize) -> String {
    if size < 0 {
        size = -size;
    }
    if text.len() as isize > size {
        let start = text.len() as isize - size;
        return text[start as usize..].to_string();
    }
    let num_of_pad = size - text.len() as isize;
    let mut pad_str = "".to_string();
    for _i in 0..num_of_pad {
        pad_str.push_str(&fill);
    }
    format!("{}{}", pad_str, text)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("no asw"), String::from("j"), 1), String::from("w"));
}
