fn f(a: Vec<isize>) -> Vec<isize> {
    let mut b = a.clone();
    let mut k = 0;
    while k < a.len() - 1 {
        b.insert(k + 1, b[k]);
        k += 2;
    }
    b.push(b[0]);
    b
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, 5, 5, 6, 4, 9]), vec![5, 5, 5, 5, 5, 5, 6, 4, 9, 5]);
}
