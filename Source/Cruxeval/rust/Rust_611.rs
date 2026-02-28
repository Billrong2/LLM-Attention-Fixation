fn f(mut nums: Vec<isize>) -> Vec<isize> {
    nums.reverse();
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-6, -2, 1, -3, 0, 1]), vec![1, 0, -3, 1, -2, -6]);
}
