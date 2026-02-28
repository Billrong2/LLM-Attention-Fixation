fn f(text: String) -> String {
    text.split_whitespace().map(|s| s.trim_start().to_string()).collect::<Vec<String>>().join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("pvtso")), String::from("pvtso"));
}
