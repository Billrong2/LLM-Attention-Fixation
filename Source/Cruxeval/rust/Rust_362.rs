fn f(text: String) -> String {
    for i in 0..text.len()-1 {
        if text[i..].chars().all(|c| c.is_lowercase()) {
            return text.chars().skip(i+1).collect::<String>();
        }
    }
    String::from("")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wrazugizoernmgzu")), String::from("razugizoernmgzu"));
}
