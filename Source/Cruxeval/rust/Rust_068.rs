use std::iter::once;

fn f(text: String, pref: String) -> String {
    if text.starts_with(&pref) {
        let n = pref.len();
        let (left, right) = text.split_at(n);
        let left: Vec<&str> = left.split('.').collect();
        let right: Vec<&str> = right.split('.').skip(1).collect();
        return [&right, &left[0..left.len() - 1]].concat().join(".")
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("omeunhwpvr.dq"), String::from("omeunh")), String::from("dq"));
}
