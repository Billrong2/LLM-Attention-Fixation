fn f(string: String, encryption: isize) -> String {
    if encryption == 0 {
        string
    } else {
        string.to_uppercase().chars().map(|c| {
            match c {
                'A'..='M' | 'a'..='m' => ((c as u8) + 13) as char,
                'N'..='Z' | 'n'..='z' => ((c as u8) - 13) as char,
                _ => c,
            }
        }).collect()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("UppEr"), 0), String::from("UppEr"));
}
