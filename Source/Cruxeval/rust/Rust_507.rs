fn f(text: String, search: String) -> isize {
    let result = text.to_lowercase();
    result.find(&search.to_lowercase()).unwrap() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("car hat"), String::from("car")), 0);
}
