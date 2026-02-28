fn f(s: String) -> String {
    if let Some(pos) = s.rfind("ar") {
        let (before, after) = s.split_at(pos);
        let (ar, after) = after.split_at(2); // "ar" has length 2
        return format!("{} {} {}", before, ar, after);
    }
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("xxxarmmarxx")), String::from("xxxarmm ar xx"));
}
