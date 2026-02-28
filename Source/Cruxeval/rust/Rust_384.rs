fn f(text: String, chars: String) -> String {
    let mut new_text = text.clone();
    let chars: Vec<char> = chars.chars().collect();
    let mut text: Vec<char> = text.chars().collect();
    
    while !new_text.is_empty() && !text.is_empty() {
        if chars.contains(&new_text.chars().next().unwrap()) {
            new_text.remove(0);
        } else {
            break;
        }
    }
    
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("asfdellos"), String::from("Ta")), String::from("sfdellos"));
}
