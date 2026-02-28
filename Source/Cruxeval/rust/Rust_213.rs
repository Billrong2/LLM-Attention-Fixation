fn f(s: String) -> String {
    s.replace("(", "[").replace(")", "]")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("(ac)")), String::from("[ac]"));
}
