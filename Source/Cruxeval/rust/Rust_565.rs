fn f(text: String) -> isize {
    text.chars().filter(|&ch| "aeiou".contains(ch)).map(|ch| text.find(ch).unwrap() as isize).max().unwrap_or(-1)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("qsqgijwmmhbchoj")), 13);
}
