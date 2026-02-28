fn f(text: String) -> isize {
    let mut x = 0;
    if text.chars().all(|c| c.is_ascii_lowercase()) {
        for c in text.chars() {
            let num = c.to_digit(10);
            if let Some(digit) = num {
                if digit < 9 {
                    x += 1;
                }
            }
        }
    }
    x
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("591237865")), 0);
}
