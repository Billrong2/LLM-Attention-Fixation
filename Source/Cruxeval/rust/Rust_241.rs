fn f(postcode: String) -> String {
    let index = postcode.find('C').unwrap_or(0);
    postcode[index..].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ED20 CW")), String::from("CW"));
}
