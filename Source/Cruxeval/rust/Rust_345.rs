fn f(a: String, b: String) -> (String, String) {
    if a < b {
        (b, a)
    } else {
        (a, b)
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ml"), String::from("mv")), (String::from("mv"), String::from("ml")));
}
