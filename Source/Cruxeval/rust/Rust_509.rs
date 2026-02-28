fn f(value: isize, width: isize) -> String {
    if value >= 0 {
        format!("{:0width$}", value, width = width as usize)
    } else {
        format!("-{:0width$}", -value, width = width as usize)
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(5, 1), String::from("5"));
}
