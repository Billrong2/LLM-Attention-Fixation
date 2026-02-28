fn f(s: String) -> String {
    let mut a: Vec<char> = s.chars().filter(|&c| c != ' ').collect();
    let mut b: Vec<char> = a.clone();
    
    for &c in a.iter().rev() {
        if c == ' ' {
            b.pop();
        } else {
            break;
        }
    }
    
    b.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hi ")), String::from("hi"));
}
