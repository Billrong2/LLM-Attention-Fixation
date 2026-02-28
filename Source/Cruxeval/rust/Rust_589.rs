fn f(num: Vec<isize>) -> Vec<isize> {
    let mut num_clone = num.clone();
    num_clone.push(*num.last().unwrap());
    num_clone
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-70, 20, 9, 1]), vec![-70, 20, 9, 1, 1]);
}
