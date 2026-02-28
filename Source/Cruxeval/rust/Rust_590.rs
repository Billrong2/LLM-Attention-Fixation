fn f(text: String) -> String {
    let mut text = text;
    for i in (0..10).rev() {
        let num_str = i.to_string();
        text = text.trim_start_matches(&num_str).to_string();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("25000   $")), String::from("5000   $"));
}
