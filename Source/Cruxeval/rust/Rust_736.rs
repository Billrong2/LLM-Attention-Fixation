fn f(text: String, insert: String) -> String {
    let whitespaces = ['\t', '\r', '\x0B', ' ', '\x0C', '\n'];
    let mut clean = String::new();

    for char in text.chars() {
        if whitespaces.contains(&char) {
            clean += &insert;
        } else {
            clean.push(char);
        }
    }

    clean
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("pi wa"), String::from("chi")), String::from("pichiwa"));
}
