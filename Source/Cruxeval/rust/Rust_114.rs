fn f(text: String, sep: String) -> Vec<String> {
    let max_split = 2;
    let mut result = vec![];
    let mut count = 0;
    let mut start = 0;
    let sep_len = sep.len();
    for (i, window) in text.as_bytes().windows(sep_len).enumerate() {
        if window == sep.as_bytes() {
            result.push(text[start..i].to_string());
            start = i + sep_len;
            count += 1;
            if count >= max_split {
                break;
            }
        }
    }
    result.push(text[start..].to_string());
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a-.-.b"), String::from("-.")), vec![String::from("a"), String::from(""), String::from("b")]);
}
