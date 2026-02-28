fn f(string: String) -> String {
    let mut string = string;
    while !string.is_empty() {
        if string.chars().last().unwrap().is_alphabetic() {
            return string;
        }
        string.pop();
    }
    string
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("--4/0-209")), String::from(""));
}
