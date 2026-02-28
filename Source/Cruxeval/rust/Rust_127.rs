fn f(text: String) -> isize {
    text.split('\n').count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("145

12fjkjg")), 3);
}
