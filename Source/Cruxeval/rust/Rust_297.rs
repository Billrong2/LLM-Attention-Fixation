fn f(num: isize) -> String {
    if num > 0 && num < 1000 && num != 6174 {
        return String::from("Half Life");
    }
    String::from("Not found")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(6173), String::from("Not found"));
}
