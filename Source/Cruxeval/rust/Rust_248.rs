fn f(mut a: Vec<isize>, mut b: Vec<isize>) -> Vec<isize> {
    a.sort();
    b.sort_by(|a, b| b.cmp(a));
    a.append(&mut b);
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![666], Vec::<isize>::new()), vec![666]);
}
