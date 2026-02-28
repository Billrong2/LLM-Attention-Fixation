fn f(text: String, new_ending: String) -> String {
    let mut result = text.into_bytes();
    result.extend(new_ending.bytes());
    String::from_utf8(result).unwrap()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jro"), String::from("wdlp")), String::from("jrowdlp"));
}
