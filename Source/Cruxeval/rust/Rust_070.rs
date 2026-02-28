fn f(x: String) -> isize {
    let mut a = 0;
    for i in x.split_whitespace() {
        let zfilled = format!("{:0width$}", i, width=i.len()*2);
        a += zfilled.len() as isize;
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("999893767522480")), 30);
}
