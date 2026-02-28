fn f(mut matr: Vec<Vec<isize>>, insert_loc: usize) -> Vec<Vec<isize>> {
    matr.insert(insert_loc, vec![]);
    matr
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![vec![5, 6, 2, 3], vec![1, 9, 5, 6]], 0), vec![vec![], vec![5, 6, 2, 3], vec![1, 9, 5, 6]]);
}
