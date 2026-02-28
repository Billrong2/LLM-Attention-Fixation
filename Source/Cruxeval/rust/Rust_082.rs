fn f(a: String, b: String, c: String, d: String) -> String {
    if !a.is_empty() {
        return b;
    }
    if !c.is_empty() {
        return d;
    }
    String::new()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("CJU"), String::from("BFS"), String::from("WBYDZPVES"), String::from("Y")), String::from("BFS"));
}
