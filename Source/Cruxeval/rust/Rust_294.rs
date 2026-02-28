fn f(n: String, m: String, text: String) -> String {
    if text.trim() == "" {
        return text;
    }
    let head = text.chars().next().unwrap().to_string();
    let tail = text.chars().last().unwrap().to_string();
    let mid = &text[1..text.len() - 1];
    
    let joined = head.replace(&n, &m) + &mid.replace(&n, &m) + &tail.replace(&n, &m);
    joined
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("x"), String::from("$"), String::from("2xz&5H3*1a@#a*1hris")), String::from("2$z&5H3*1a@#a*1hris"));
}
