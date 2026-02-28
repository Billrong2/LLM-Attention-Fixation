fn f(mut xs: Vec<isize>) -> Vec<isize> {
    for _ in 0..xs.len() {
        if let Some(first_element) = xs.pop() {
            xs.insert(0, first_element);
        }
    }
    xs
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3]), vec![1, 2, 3]);
}
