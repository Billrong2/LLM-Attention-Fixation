fn f(text: String, digit: String) -> isize {
    let count = text.matches(&digit).count();
    digit.parse::<isize>().unwrap() * count as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("7Ljnw4Lj"), String::from("7")), 7);
}
