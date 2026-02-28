fn f(text: String, to_remove: String) -> String {
    let mut new_text: Vec<char> = text.chars().collect();
    
    if new_text.contains(&to_remove.chars().next().unwrap()) {
        let index = new_text.iter().position(|&c| c == to_remove.chars().next().unwrap()).unwrap();
        new_text.remove(index);
        new_text.insert(index, '?');
        new_text.retain(|&c| c != '?');
    }
    
    new_text.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("sjbrlfqmw"), String::from("l")), String::from("sjbrfqmw"));
}
