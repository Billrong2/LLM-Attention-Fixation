fn f(text: String, value: String) -> String {
    let mut indexes = Vec::new();
    for i in 0..text.len() {
        if text.chars().nth(i).unwrap() == value.chars().next().unwrap() {
            indexes.push(i);
        }
    }
    
    let mut new_text: Vec<char> = text.chars().collect();
    for &i in &indexes {
        new_text.retain(|&c| c != value.chars().next().unwrap());
    }
    
    new_text.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("scedvtvotkwqfoqn"), String::from("o")), String::from("scedvtvtkwqfqn"));
}
