fn f(n: String) -> String {
    let length = n.len() + 2;
    let mut revn: Vec<char> = n.chars().collect();
    let result: String = revn.iter().collect();
    revn.clear();
    return result + &"!".repeat(length);
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("iq")), String::from("iq!!!!"));
}
