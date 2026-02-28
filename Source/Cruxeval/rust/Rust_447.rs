fn f(text: String, tab_size: isize) -> String {
    let mut res = String::new();
    let text = text.replace("\t", &" ".repeat((tab_size - 1) as usize));
    
    for c in text.chars() {
        if c == ' ' {
            res.push('|');
        } else {
            res.push(c);
        }
    }

    res
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("	a"), 3), String::from("||a"));
}
