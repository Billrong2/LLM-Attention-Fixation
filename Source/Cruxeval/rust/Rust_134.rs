fn f(n: isize) -> String {
    let mut t = 0;
    let mut b = String::new();
    let digits: Vec<u32> = n.to_string().chars().map(|c| c.to_digit(10).unwrap()).collect();
    for &d in &digits {
        if d == 0 {
            t += 1;
        } else {
            break;
        }
    }
    for _ in 0..t {
        b.push_str("1014");
    }
    b.push_str(&n.to_string());
    b
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(372359), String::from("372359"));
}
