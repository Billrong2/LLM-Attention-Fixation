fn f(text: String) -> String {
    let mut text = text.chars().collect::<Vec<char>>();
    for i in (0..text.len()).rev() {
        if text[i] == ' ' {
            text[i] = '&';
            text.insert(i+1, 'n');
            text.insert(i+2, 'b');
            text.insert(i+3, 's');
            text.insert(i+4, 'p');
            text.insert(i+5, ';');
        }
    }
    text.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("   ")), String::from("&nbsp;&nbsp;&nbsp;"));
}
