fn f(test_str: String) -> String {
    let s = test_str.replace("a", "A");
    s.replace("e", "A")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("papera")), String::from("pApArA"));
}
