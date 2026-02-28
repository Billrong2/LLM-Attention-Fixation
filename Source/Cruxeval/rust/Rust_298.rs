fn f(text: String) -> String {
    let mut new_text = text.chars().collect::<Vec<char>>();
    for i in 0..new_text.len() {
        let character = new_text[i];
        let new_character = character.to_ascii_uppercase();
        new_text[i] = new_character;
    }
    new_text.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dst vavf n dmv dfvm gamcu dgcvb.")), String::from("DST VAVF N DMV DFVM GAMCU DGCVB."));
}
