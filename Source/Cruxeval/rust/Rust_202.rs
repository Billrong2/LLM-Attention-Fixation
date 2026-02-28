fn f(mut array: Vec<isize>, lst: Vec<isize>) -> Vec<isize> {
    array.extend(lst);
    array.into_iter().filter(|&e| e >= 10).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 15], vec![15, 1]), vec![15, 15]);
}
