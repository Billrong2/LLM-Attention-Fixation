fn f(text: String, rules: Vec<String>) -> String {
    let mut text = text;
    for rule in rules {
        if rule == "@" {
            text = text.chars().rev().collect();
        } else if rule == "~" {
            text = text.to_uppercase();
        } else if let Some(last_char) = text.chars().last() {
            if last_char == rule.chars().next().unwrap() {
                text.pop();
            }
        }
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hi~!"), vec![String::from("~"), String::from("`"), String::from("!"), String::from("&")]), String::from("HI~"));
}
