fn f(n: isize) -> Vec<String> {
    let mut b: Vec<String> = n.to_string().chars().map(|c| c.to_string()).collect();
    for i in 2..b.len() {
        b[i] += "+";
    }
    b
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(44), vec![String::from("4"), String::from("4")]);
}
