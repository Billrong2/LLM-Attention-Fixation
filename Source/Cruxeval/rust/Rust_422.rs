fn f(array: Vec<isize>) -> Vec<isize> {
    let mut new_array = array.clone();
    new_array.reverse();
    new_array.iter().map(|&x| x*x).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 1]), vec![1, 4, 1]);
}
