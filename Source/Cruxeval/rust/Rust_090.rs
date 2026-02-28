fn f(array: Vec<Vec<isize>>) -> Vec<Vec<isize>> {
    let mut return_arr: Vec<Vec<isize>> = Vec::new();
    for a in &array {
        return_arr.push(a.clone());
    }
    return return_arr;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![vec![1, 2, 3], vec![], vec![1, 2, 3]]), vec![vec![1, 2, 3], vec![], vec![1, 2, 3]]);
}
