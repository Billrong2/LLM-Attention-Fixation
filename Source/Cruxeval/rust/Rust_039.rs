fn f(array: Vec<isize>, elem: isize) -> isize {
    if let Some(index) = array.iter().position(|&x| x == elem) {
        index as isize
    } else {
        -1
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 2, 7, 1], 6), 0);
}
