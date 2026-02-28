fn f(s: String, sep: String) -> String {
    let reverse: Vec<String> = s.split(&sep).map(|e| format!("*{}", e)).collect();
    reverse.iter().rev().cloned().collect::<Vec<String>>().join(";")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("volume"), String::from("l")), String::from("*ume;*vo"));
}
