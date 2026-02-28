fn f(name: String) -> String {
    format!("| {} |", name.split_whitespace().collect::<Vec<&str>>().join(" "))
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("i am your father")), String::from("| i am your father |"));
}
