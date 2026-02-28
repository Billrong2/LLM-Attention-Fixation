fn f(text: String, num_digits: isize) -> String {
    let width = std::cmp::max(1, num_digits);
    let zeros = "0".repeat(width as usize - text.len());
    zeros + &text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("19"), 5), String::from("00019"));
}
