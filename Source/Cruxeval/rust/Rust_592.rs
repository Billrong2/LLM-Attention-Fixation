fn f(numbers: Vec<isize>) -> Vec<isize> {
    let mut new_numbers: Vec<isize> = Vec::new();
    for i in 0..numbers.len() {
        new_numbers.push(numbers[numbers.len() - 1 - i]);
    }
    new_numbers
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![11, 3]), vec![3, 11]);
}
