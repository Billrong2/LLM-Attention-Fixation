use std::collections::HashMap;

fn f(text: String, repl: String) -> String {
    let trans: HashMap<char, char> = text.to_lowercase().chars().zip(repl.to_lowercase().chars()).collect();
    text.chars().map(|c| *trans.get(&c).unwrap_or(&c)).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("upper case"), String::from("lower case")), String::from("lwwer case"));
}
