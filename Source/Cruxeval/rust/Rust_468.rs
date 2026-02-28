fn f(a: String, b: String, n: usize) -> String {
    let mut result = b.clone();
    let mut m = b.clone();
    for _ in 0..n {
        if !m.is_empty() {
            let (a, m) = (a.replace(&m, ""), String::new());
            result = b.clone();
        }
    }
    a.split(&b).collect::<Vec<&str>>().join(&result)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("unrndqafi"), String::from("c"), 2), String::from("unrndqafi"));
}
