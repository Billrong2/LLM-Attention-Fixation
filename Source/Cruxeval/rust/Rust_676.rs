fn f(text: String, tab_size: isize) -> String {
    text.replace("\t", &" ".repeat(tab_size as usize))
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a"), 100), String::from("a"));
}
