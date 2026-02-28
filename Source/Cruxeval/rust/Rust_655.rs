fn f(s: String) -> String {
    s.replace('a', "").replace('r', "")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("rpaar")), String::from("p"));
}
