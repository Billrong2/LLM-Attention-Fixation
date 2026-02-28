fn f(text: String, delim: String) -> String {
    let parts: Vec<&str> = text.split(&delim).collect();
    return format!("{}{}{}", parts[1], delim, parts[0]);
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bpxa24fc5."), String::from(".")), String::from(".bpxa24fc5"));
}
