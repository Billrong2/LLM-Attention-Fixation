fn f(text: String, value: String) -> String {
    if !text.contains(&value) {
        return String::from("");
    }
    let parts: Vec<&str> = text.rsplitn(2, &value).collect();
    return parts[1].to_string();
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mmfbifen"), String::from("i")), String::from("mmfb"));
}
