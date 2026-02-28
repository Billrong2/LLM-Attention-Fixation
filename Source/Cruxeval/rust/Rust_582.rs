fn f(k: isize, j: isize) -> Vec<isize> {
    let mut arr = Vec::new();
    for _ in 0..k {
        arr.push(j);
    }
    arr
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(7, 5), vec![5, 5, 5, 5, 5, 5, 5]);
}
