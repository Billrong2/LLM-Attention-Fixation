fn f(text: String) -> String {
    let mut new_text: Vec<char> = text.chars().collect();
    let mut i = 0;
    while i < new_text.len() {
        if new_text[i] == '+' {
            new_text.remove(i);
        } else {
            i += 1;
        }
    }
    new_text.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hbtofdeiequ")), String::from("hbtofdeiequ"));
}
