fn f(r: String, w: String) -> Vec<String> {
    let mut a: Vec<String> = Vec::new();
    if r.chars().next() == w.chars().next() && w.chars().rev().next() == r.chars().rev().next() {
        a.push(r.clone());
        a.push(w.clone());
    } else {
        a.push(w.clone());
        a.push(r.clone());
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ab"), String::from("xy")), vec![String::from("xy"), String::from("ab")]);
}
