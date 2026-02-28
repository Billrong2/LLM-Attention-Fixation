fn f(text: String) -> String {
    let n = text.find('8').unwrap_or(text.len());
    "x0".repeat(n)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("sa832d83r xd 8g 26a81xdf")), String::from("x0x0"));
}
