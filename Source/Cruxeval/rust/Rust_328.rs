fn f(mut array: Vec<isize>, L: isize) -> Vec<isize> {
    if L <= 0 {
        return array;
    }
    if (array.len() as isize) < L {
        array.append(&mut f(array.clone(), L - array.len() as isize));
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3], 4), vec![1, 2, 3, 1, 2, 3]);
}
