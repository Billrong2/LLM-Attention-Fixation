fn f(s: String, from_c: String, to_c: String) -> String {
    s.chars().map(|c| {
        if let Some(index) = from_c.find(c) {
            to_c.chars().nth(index).unwrap()
        } else {
            c
        }
    }).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("aphid"), String::from("i"), String::from("?")), String::from("aph?d"));
}
