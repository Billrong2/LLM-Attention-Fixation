fn f(text: String, suffix: String, num: isize) -> bool {
    let str_num = num.to_string();
    text.ends_with(&(suffix.to_owned() + &str_num))
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("friends and love"), String::from("and"), 3), false);
}
