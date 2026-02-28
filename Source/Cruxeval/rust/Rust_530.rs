fn f(s: String, ch: String) -> String {
    let mut sl = s.clone();
    if sl.contains(&ch) {
        sl = sl.trim_start_matches(&ch).to_string();
        if sl.is_empty() {
            sl.push_str("!?");
        }
    } else {
        return "no".to_string();
    }
    sl
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("@@@ff"), String::from("@")), String::from("ff"));
}
