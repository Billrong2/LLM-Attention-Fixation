fn f(text: String) -> String {
    let nums: Vec<char> = text.chars().filter(|c| c.is_numeric()).collect();
    assert!(nums.len() > 0);
    nums.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("-123   	+314")), String::from("123314"));
}
