use std::str;
use std::iter::FromIterator;

fn f(test: String, sep: String, maxsplit: isize) -> Vec<String> {
    if maxsplit == -1 {
        Vec::from_iter(test.rsplit(&sep).map(|s| s.to_string()))
    } else {
        Vec::from_iter(test.rsplitn(maxsplit as usize, &sep).map(|s| s.to_string()))
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ab cd"), String::from("x"), 2), vec![String::from("ab cd")]);
}
