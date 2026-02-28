fn f(n: isize, m: isize) -> Vec<isize> {
    let mut arr: Vec<isize> = (1..=n).collect();
    for _ in 0..m {
        arr.clear();
    }
    arr
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1, 3), Vec::<isize>::new());
}
