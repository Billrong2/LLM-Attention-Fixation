fn f(mut s1: String, s2: String) -> bool {
    for _k in 0..s2.len() + s1.len() {
        s1.push_str(&s1.chars().next().unwrap().to_string());
        if s1.find(&s2).is_some() {
            return true;
        }
    }
    
    false
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hello"), String::from(")")), false);
}
