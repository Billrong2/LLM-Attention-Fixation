fn f(L: Vec<isize>) -> Vec<isize> {
    let mut L = L;
    let N = L.len();
    for k in 1..=N/2 {
        let mut i = k - 1;
        let mut j = N - k;
        while i < j {
            // swap elements:
            L.swap(i, j);
            // update i, j:
            i += 1;
            j -= 1;
        }
    }
    L
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![16, 14, 12, 7, 9, 11]), vec![11, 14, 7, 12, 9, 16]);
}
