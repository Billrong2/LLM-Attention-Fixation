fn f(text: String, delimiter: String) -> String {
    let parts: Vec<&str> = text.rsplitn(2, &delimiter).collect();
    parts[0].to_string() + parts[1]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("xxjarczx"), String::from("x")), String::from("xxjarcz"));
}
