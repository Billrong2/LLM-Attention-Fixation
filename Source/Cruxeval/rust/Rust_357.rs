fn f(s: String) -> String {
    let mut r = Vec::new();
    for i in (0..s.len()).rev() {
        r.push(s.chars().nth(i).unwrap());
    }
    r.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("crew")), String::from("werc"));
}
