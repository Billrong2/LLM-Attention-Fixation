fn f(str: String, toget: String) -> String {
    if str.starts_with(&toget) {
        str[toget.len()..].to_string()
    } else {
        str
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("fnuiyh"), String::from("ni")), String::from("fnuiyh"));
}
