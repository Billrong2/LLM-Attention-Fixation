fn f(text: String) -> isize {
    let mut result_list: Vec<&str> = vec!["3", "3", "3", "3"];
    if !result_list.is_empty() {
        result_list.clear();
    }
    text.len() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mrq7y")), 5);
}
