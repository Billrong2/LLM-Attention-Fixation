fn f(text: String) -> String {
    let mut ls: Vec<char> = text.chars().collect();
    let length = ls.len();
    for i in 0..length {
        ls.insert(i, ls[i]);
    }
    let result = ls.iter().collect::<String>();
    format!("{:<width$}", result, width=length*2)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hzcw")), String::from("hhhhhzcw"));
}
