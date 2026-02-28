fn f(temp: isize, timeLimit: isize) -> String {
    let s = timeLimit / temp;
    let e = timeLimit % temp;
    if s > 1 {
        return format!("{} {}", s, e);
    } else {
        return format!("{} oC", e);
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1, 1234567890), String::from("1234567890 0"));
}
