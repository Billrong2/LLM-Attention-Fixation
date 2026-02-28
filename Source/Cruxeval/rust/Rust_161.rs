fn f(text: String, value: String) -> String {
    let parts: Vec<&str> = text.splitn(2, &value).collect();
    format!("{}{}", parts[1], parts[0])
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("difkj rinpx"), String::from("k")), String::from("j rinpxdif"));
}
