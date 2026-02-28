fn f(text: String) -> String {
    let mut new_text: Vec<char> = text.chars().collect();
    let mut total = (text.len() - 1) * 2;
    for i in 1..=total {
        if i % 2 != 0 {
            new_text.push('+');
        } else {
            new_text.insert(0, '+');
        }
    }
    let result = new_text.into_iter().collect::<String>();
    format!("{:>width$}", result, width = total)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("taole")), String::from("++++taole++++"));
}
