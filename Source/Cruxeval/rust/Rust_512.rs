fn f(s: String) -> bool {
    s.len() == s.matches('0').count() + s.matches('1').count()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("102")), false);
}
