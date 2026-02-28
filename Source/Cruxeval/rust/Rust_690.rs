fn f(n: String) -> String {
    if n.contains('.') {
        return (n.parse::<f64>().unwrap() + 2.5).to_string();
    }
    n
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("800")), String::from("800"));
}
