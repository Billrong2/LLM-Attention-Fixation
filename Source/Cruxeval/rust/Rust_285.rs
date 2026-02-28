fn f(text: String, ch: String) -> isize {
    text.matches(ch.as_str()).count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("This be Pirate's Speak for 'help'!"), String::from(" ")), 5);
}
