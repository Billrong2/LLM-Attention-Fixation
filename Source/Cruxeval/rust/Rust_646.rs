fn f(text: String, count: isize) -> String {
    let mut text = text;
    for _ in 0..count {
        text = text.chars().rev().collect::<String>();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("aBc, ,SzY"), 2), String::from("aBc, ,SzY"));
}
