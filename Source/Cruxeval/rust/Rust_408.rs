fn f(mut m: Vec<isize>) -> Vec<isize> {
    m.reverse();
    m
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-4, 6, 0, 4, -7, 2, -1]), vec![-1, 2, -7, 4, 0, 6, -4]);
}
