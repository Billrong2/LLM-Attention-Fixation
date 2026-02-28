fn f(file: String) -> isize {
    file.find('\n').unwrap() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("n wez szize lnson tilebi it 504n.
")), 33);
}
