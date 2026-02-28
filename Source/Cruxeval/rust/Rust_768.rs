fn f(s: String, o: String) -> String {
    if s.starts_with(&o) {
        return s;
    }
    let reversed_o: String = o.chars().rev().collect();
    return format!("{}{}", o, f(s, reversed_o.chars().skip(1).collect::<String>()));
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abba"), String::from("bab")), String::from("bababba"));
}
