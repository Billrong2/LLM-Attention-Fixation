fn f(text: String, s: isize, e: isize) -> isize {
    let sublist = &text[s as usize..e as usize];
    if sublist.is_empty() {
        return -1;
    }
    sublist.chars().position(|c| c == sublist.chars().min().unwrap()).unwrap() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("happy"), 0, 3), 1);
}
