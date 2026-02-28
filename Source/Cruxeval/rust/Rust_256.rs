fn f(text: String, sub: String) -> isize {
    let mut a = 0;
    let mut b = text.len() as isize - 1;

    while a <= b {
        let c = (a + b) / 2;
        if let Some(index) = text.rfind(&sub) {
            if index >= c as usize {
                a = c + 1;
            } else {
                b = c - 1;
            }
        } else {
            b = c - 1;
        }
    }

    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dorfunctions"), String::from("2")), 0);
}
