fn f(text: String) -> String {
    let mut my_list: Vec<&str> = text.split_whitespace().collect();
    my_list.sort_by(|a, b| b.cmp(a));
    my_list.join(" ").to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a loved")), String::from("loved a"));
}
