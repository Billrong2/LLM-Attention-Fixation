fn f(s: String, tab: isize) -> String {
    s.replace("\t", &" ".repeat(tab as usize))
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Join us in Hungary"), 4), String::from("Join us in Hungary"));
}
