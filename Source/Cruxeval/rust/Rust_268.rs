fn f(s: String, separator: String) -> String {
    let separator_char = separator.chars().next().unwrap();
    for (i, c) in s.chars().enumerate() {
        if c == separator_char {
            let mut new_s: Vec<char> = s.chars().collect();
            new_s[i] = '/';
            return new_s.iter().map(|c| c.to_string()).collect::<Vec<String>>().join(" ");
        }
    }
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("h grateful k"), String::from(" ")), String::from("h / g r a t e f u l   k"));
}
