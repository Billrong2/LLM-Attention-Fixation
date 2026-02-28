fn f(array: Vec<isize>, elem: isize) -> isize {
    let ind = array.iter().position(|&x| x == elem).unwrap();
    return ind as isize * 2 + array[array.len() - ind - 1] * 3;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, 2, 1, -8, 2], 2), -22);
}
