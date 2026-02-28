fn f(text: String) -> String {
    let text_lower = text.to_lowercase();
    let text_capitalize = text.to_lowercase();
    let mut chars = text_capitalize.chars().collect::<Vec<char>>();
    if let Some(c) = chars.get_mut(0) {
        *c = c.to_uppercase().next().unwrap();
    }
    let capitalize: String = chars.into_iter().collect();
    format!("{}{}", &text_lower[0..1], &capitalize[1..])
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("this And cPanel")), String::from("this and cpanel"));
}
