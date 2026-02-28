fn f(text: String) -> String {
    let mut result = String::new();
    let mut i = text.len() as isize - 1;
    while i >= 0 {
        let c = text.chars().nth(i as usize).unwrap();
        if c.is_alphabetic() {
            result.push(c);
        }
        i -= 1;
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("102x0zoq")), String::from("qozx"));
}
