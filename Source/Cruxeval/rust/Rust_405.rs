fn f(xs: Vec<isize>) -> Vec<isize> {
    let mut xs = xs;
    let mut new_x = xs[0] - 1;
    xs.remove(0);
    while new_x <= xs[0] {
        xs.remove(0);
        new_x -= 1;
    }
    xs.insert(0, new_x);
    xs
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 3, 4, 1, 2, 3, 5]), vec![5, 3, 4, 1, 2, 3, 5]);
}
