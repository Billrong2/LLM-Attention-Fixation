fn f(text: String) -> isize {
    text.len() as isize - text.matches("bot").count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Where is the bot in this world?")), 30);
}
