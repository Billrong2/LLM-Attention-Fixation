fn f(text: String) -> String {
    let mut count = text.matches(text.chars().next().unwrap()).count();
    let mut ls: Vec<char> = text.chars().collect();
    
    for _ in 0..count {
        ls.remove(0);
    }
    
    ls.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(";,,,?")), String::from(",,,?"));
}
