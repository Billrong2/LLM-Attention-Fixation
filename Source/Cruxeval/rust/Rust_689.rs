fn f(arr: Vec<isize>) -> Vec<isize> {
    let mut sub = arr.clone();
    let count = sub.len();
    for i in (0..count).step_by(2) {
        sub[i] *= 5;
    }
    sub
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-3, -6, 2, 7]), vec![-15, -6, 10, 7]);
}
