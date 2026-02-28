fn f(haystack: String, needle: String) -> isize {
    for i in (0..haystack.find(&needle).unwrap_or(0) + 1).rev() {
        if Some(&haystack[i..]) == Some(&needle) {
            return i as isize;
        }
    }
    -1
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("345gerghjehg"), String::from("345")), -1);
}
