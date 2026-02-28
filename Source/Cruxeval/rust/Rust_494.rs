fn f(num: String, mut l: isize) -> String {
    let mut t = String::new();
    while l > num.len() as isize {
        t.push_str("0");
        l -= 1;
    }
    t + &num
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("1"), 3), String::from("001"));
}
