fn f(matrix: Vec<Vec<isize>>) -> Vec<Vec<isize>> {
    let mut result = Vec::new();
    let mut matrix = matrix;
    matrix.reverse();
    for mut primary in matrix {
        primary.sort_by(|a, b| b.cmp(a));
        result.push(primary);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![vec![1, 1, 1, 1]]), vec![vec![1, 1, 1, 1]]);
}
