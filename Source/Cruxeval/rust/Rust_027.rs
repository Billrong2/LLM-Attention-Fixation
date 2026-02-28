fn f(w: String) -> bool {
    let mut ls: Vec<char> = w.chars().collect();
    let mut omw = String::new();
    while !ls.is_empty() {
        omw.push(ls.remove(0));
        if ls.len() * 2 > w.len() {
            return &w[ls.len()..] == omw;
        }
    }
    false
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("flak")), false);
}
