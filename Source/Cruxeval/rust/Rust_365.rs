fn f(n: String, s: String) -> String {
    if s.starts_with(&n) {
        let parts: Vec<&str> = s.splitn(2, &n).collect();
        if let [pre, _] = parts.as_slice() {
            return format!("{}{}{}", pre, n, &s[n.len()..]);
        }
    }
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("xqc"), String::from("mRcwVqXsRDRb")), String::from("mRcwVqXsRDRb"));
}
