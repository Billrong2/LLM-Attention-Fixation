use std::iter::repeat;

fn f(text: String, value: String) -> String {
    let len_value = value.len();
    let len_text = text.len();
    if len_text < len_value {
        let diff = len_value - len_text;
        let question_marks: String = repeat("?").take(diff).collect();
        return format!("{}{}", text, question_marks);
    } else {
        return text;
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("!?"), String::from("")), String::from("!?"));
}
