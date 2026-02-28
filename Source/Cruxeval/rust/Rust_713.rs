fn f(text: String, char: String) -> bool {
    text.contains(&char) && {
        let text = text.split(&char)
            .filter(|t| !t.trim().is_empty())
            .collect::<Vec<&str>>();
        text.len() > 1
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("only one line"), String::from(" ")), true);
}
