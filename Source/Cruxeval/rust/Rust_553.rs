fn f(text: String, count: isize) -> String {
    let mut text = text;
    for _ in 0..count {
        text = text.chars().rev().collect::<String>();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("439m2670hlsw"), 3), String::from("wslh0762m934"));
}
