fn f(digits: Vec<isize>) -> Vec<isize> {
    let mut digits = digits;
    digits.reverse();
    if digits.len() < 2 {
        return digits;
    }
    for i in (0..digits.len()).step_by(2) {
        digits.swap(i, i + 1);
    }
    digits
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2]), vec![1, 2]);
}
