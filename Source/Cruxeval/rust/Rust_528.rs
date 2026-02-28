fn f(s: String) -> isize {
    let mut b = String::new();
    let mut c = String::new();
    for i in s.chars() {
        c.push(i);
        if let Some(idx) = s.rfind(&c) {
            return idx as isize;
        }
    }
    0
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("papeluchis")), 2);
}
