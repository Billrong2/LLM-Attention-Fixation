fn f(single_digit: isize) -> Vec<isize> {
    let mut result = vec![];
    for c in 1..11 {
        if c != single_digit {
            result.push(c);
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(5), vec![1, 2, 3, 4, 6, 7, 8, 9, 10]);
}
