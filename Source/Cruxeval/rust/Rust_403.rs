fn f(full: String, part: String) -> isize {
    let mut full = full;
    let length = part.len();
    let mut index = full.find(&part);
    let mut count = 0;
    while let Some(i) = index {
        full = full[i + length..].to_string();
        index = full.find(&part);
        count += 1;
    }
    count as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hrsiajiajieihruejfhbrisvlmmy"), String::from("hr")), 2);
}
