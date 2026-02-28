fn f(a: Vec<isize>) -> Vec<isize> {
    let mut a = a;
    if a.len() >= 2 && a[0] > 0 && a[1] > 0 {
        a.reverse();
        return a;
    }
    a.push(0);
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), vec![0]);
}
