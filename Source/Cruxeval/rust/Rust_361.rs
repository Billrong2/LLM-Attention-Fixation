fn f(text: String) -> isize {
    text.split(':').next().unwrap_or("").chars().filter(|&c| c == '#').count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("#! : #!")), 1);
}
