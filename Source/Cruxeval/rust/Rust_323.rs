fn f(text: String) -> isize {
    text.split("\n").count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ncdsdfdaaa0a1cdscsk*XFd")), 1);
}
