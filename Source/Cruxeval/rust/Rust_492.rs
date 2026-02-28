fn f(text: String, value: String) -> String {
    let mut ls: Vec<char> = text.chars().collect();
    if ls.iter().filter(|&c| *c == value.chars().next().unwrap()).count() % 2 == 0 {
        while ls.contains(&value.chars().next().unwrap()) {
            if let Some(pos) = ls.iter().position(|&c| c == value.chars().next().unwrap()) {
                ls.remove(pos);
            }
        }
    } else {
        ls.clear();
    }
    ls.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abbkebaniuwurzvr"), String::from("m")), String::from("abbkebaniuwurzvr"));
}
