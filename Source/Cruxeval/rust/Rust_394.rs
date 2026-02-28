fn f(text: String) -> isize {
    let k = text.split('\n');
    let mut i = 0;
    for j in k {
        if j.len() == 0 {
            return i;
        }
        i += 1;
    }
    -1
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("2 m2 

bike")), 1);
}
