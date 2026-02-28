fn f(text: String) -> String {
    text.split('\n').collect::<Vec<&str>>().join(", ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("BYE
NO
WAY")), String::from("BYE, NO, WAY"));
}
