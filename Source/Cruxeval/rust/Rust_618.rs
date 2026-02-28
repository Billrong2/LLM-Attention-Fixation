fn f(r#match: String, fill: String, n: isize) -> String {
    let filled_part = fill.chars().take(n as usize).collect::<String>();
    let result = filled_part + &r#match;
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("9"), String::from("8"), 2), String::from("89"));
}
