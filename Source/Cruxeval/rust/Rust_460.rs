fn f(text: String, amount: usize) -> String {
    let length = text.len();
    let mut pre_text = String::from("|");
    if amount >= length {
        let extra_space = amount - length;
        pre_text.push_str(&" ".repeat(extra_space / 2));
        return format!("{}{}{}", pre_text, text, pre_text);
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("GENERAL NAGOOR"), 5), String::from("GENERAL NAGOOR"));
}
