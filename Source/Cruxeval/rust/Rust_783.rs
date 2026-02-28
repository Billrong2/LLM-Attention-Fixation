fn f(text: String, comparison: String) -> isize {
    let length = comparison.len();
    if length <= text.len() {
        for i in 0..length {
            if comparison.chars().rev().nth(i) != text.chars().rev().nth(i) {
                return i as isize;
            }
        }
    }
    length as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("managed"), String::from("")), 0);
}
