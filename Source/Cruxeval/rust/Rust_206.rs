fn f(a: String) -> String {
    a.split_whitespace().collect::<Vec<_>>().join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(" h e l l o   w o r l d! ")), String::from("h e l l o w o r l d!"));
}
