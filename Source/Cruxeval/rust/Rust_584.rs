fn f(txt: String) -> String {
    txt
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("5123807309875480094949830")), String::from("5123807309875480094949830"));
}
