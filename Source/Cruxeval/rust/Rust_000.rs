fn f(nums: Vec<isize>) -> Vec<(isize, isize)> {
    let mut output: Vec<(isize, isize)> = Vec::new();
    for &n in &nums {
        output.push((nums.iter().filter(|&x| *x == n).count() as isize, n));
    }
    output.sort_by(|a, b| b.0.cmp(&a.0));
    output
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1, 3, 1, 3, 1]), vec![(4, 1), (4, 1), (4, 1), (4, 1), (2, 3), (2, 3)]);
}
