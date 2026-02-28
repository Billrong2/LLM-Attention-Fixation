fn f(text: String, changes: String) -> String {
    let mut result = String::new();
    let mut count = 0;
    let mut changes = changes.chars().collect::<Vec<char>>();
    for char in text.chars() {
        if char == 'e' {
            result.push(char);
        } else {
            result.push(changes[count % changes.len()]);
        }
        count += if char != 'e' { 1 } else { 0 };
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("fssnvd"), String::from("yes")), String::from("yesyes"));
}
