fn f(bots: Vec<String>) -> isize {
    let mut clean: Vec<String> = Vec::new();
    for username in bots {
        if !username.chars().all(char::is_uppercase) {
            clean.push(format!("{}{}", &username[..2], &username[username.len()-3..]));
        }
    }
    clean.len() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("yR?TAJhIW?n"), String::from("o11BgEFDfoe"), String::from("KnHdn2vdEd"), String::from("wvwruuqfhXbGis")]), 4);
}
