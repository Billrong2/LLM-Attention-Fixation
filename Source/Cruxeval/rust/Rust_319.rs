fn f(needle: String, haystack: String) -> isize {
    let mut count = 0;
    let mut haystack = haystack.clone();
    while haystack.contains(&needle) {
        haystack = haystack.replacen(&needle, "", 1);
        count += 1;
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a"), String::from("xxxaaxaaxx")), 4);
}
