fn f(n: isize) -> String {
    let mut p = String::new();
    if n % 2 == 1 {
        p.push_str("sn");
    } else {
        return n.to_string();
    }
    for x in 1..=n {
        if x % 2 == 0 {
            p.push_str("to");
        } else {
            p.push_str("ts");
        }
    }
    p
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1), String::from("snts"));
}
