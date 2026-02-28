fn f(n: isize) -> bool {
    for n in n.to_string().chars() {
        if !['0', '1', '2'].contains(&n) && !(5..=9).contains(&(n.to_digit(10).unwrap_or(0) as isize)) {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1341240312), false);
}
