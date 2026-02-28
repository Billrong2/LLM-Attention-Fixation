fn f(text: String) -> String {
    let mut text2 = String::new();
    let ls: Vec<char> = text.chars().collect();
    for i in (3..ls.len()).step_by(3) {
        let mut temp = String::new();
        for j in (i-3..i).rev() {
            temp.push(ls[j]);
            temp.push_str("---");
        }
        text2.push_str(&temp[0..temp.len()-3]);
        text2.push_str("---");
    }
    text2.trim_end_matches('-').to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("scala")), String::from("a---c---s"));
}
