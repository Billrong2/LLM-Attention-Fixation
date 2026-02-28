fn f(text: String, search_string: String) -> Vec<isize> {
    let mut text = text; // Make a mutable copy of text
    let mut indexes: Vec<isize> = Vec::new();
    
    while text.contains(&search_string) {
        let index = text.rfind(&search_string).unwrap();
        indexes.push(index as isize);
        text = text[..index].to_string();
    }
    
    indexes
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ"), String::from("J")), vec![28, 19, 12, 6]);
}
