fn f(text: String, function: String) -> Vec<isize> {
    let mut cites: Vec<isize> = vec![text[text.find(&function).unwrap() + function.len()..].len() as isize];
    for char in text.chars() {
        if char.to_string() == function {
            cites.push(text[text.find(&function).unwrap() + function.len()..].len() as isize);
        }
    }
    cites
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("010100"), String::from("010")), vec![3]);
}
