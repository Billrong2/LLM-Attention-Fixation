fn f(text: String) -> String {
    let mut a: Vec<&str> = text.trim().split(' ').collect();
    for i in 0..a.len() {
        if !a[i].chars().all(char::is_numeric) {
            return "-".to_string();
        }
    }
    a.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("d khqw whi fwi bbn 41")), String::from("-"));
}
