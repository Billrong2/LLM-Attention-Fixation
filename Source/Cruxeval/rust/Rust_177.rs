fn f(text: String) -> String {
    let mut new_text = text.chars().collect::<Vec<char>>();
    for i in 0..new_text.len() {
        if i % 2 == 1 {
            new_text[i] = if new_text[i].is_lowercase() {
                new_text[i].to_uppercase().next().unwrap()
            } else {
                new_text[i].to_lowercase().next().unwrap()
            };
        }
    }
    new_text.into_iter().collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hey DUdE THis $nd^ &*&this@#")), String::from("HEy Dude tHIs $Nd^ &*&tHiS@#"));
}
