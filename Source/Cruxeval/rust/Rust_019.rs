fn f(x: String, y: String) -> String {
    let tmp: String = y.chars().rev().map(|c| if c == '9' { '0' } else { '9' }).collect();
    if x.parse::<i32>().is_ok() && tmp.parse::<i32>().is_ok() {
        return format!("{}{}", x, tmp);
    } else {
        return x;
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(""), String::from("sdasdnakjsda80")), String::from(""));
}
