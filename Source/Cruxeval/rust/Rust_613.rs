fn f(text: String) -> String {
    let mut result = String::new();
    let mid = (text.len() - 1) / 2;
    for i in 0..mid {
        result.push_str(&text[i..=i]);
    }
    for i in mid..text.len()-1 {
        result.push_str(&text[(mid + text.len() - 1 - i)..=(mid + text.len() - 1 - i)]);
    }
    result.push_str(&text.chars().last().unwrap().to_string().repeat(text.len() - result.len()));
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("eat!")), String::from("e!t!"));
}
