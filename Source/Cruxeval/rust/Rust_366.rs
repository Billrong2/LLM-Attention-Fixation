fn f(string: String) -> String {
    let mut tmp = string.to_lowercase();
    for char in string.to_lowercase().chars() {
        if tmp.contains(char) {
            tmp = tmp.replacen(char, "", 1);
        }
    }
    tmp
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("[ Hello ]+ Hello, World!!_ Hi")), String::from(""));
}
