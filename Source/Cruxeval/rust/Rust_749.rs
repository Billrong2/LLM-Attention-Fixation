fn f(text: String, width: usize) -> String {
    let mut result = String::new();
    for line in text.lines() {
        let space_count = width - line.len();
        let left_space = space_count / 2;
        let right_space = space_count - left_space;
        let left_space_str = " ".repeat(left_space);
        let right_space_str = " ".repeat(right_space);
        result.push_str(&format!("{}{}{}\n", left_space_str, line, right_space_str));
    }
    result.pop(); // Remove the very last new line character
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("l
l"), 2), String::from("l 
l "));
}
