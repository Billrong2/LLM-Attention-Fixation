fn f(mut nums: Vec<isize>, start: usize, k: usize) -> Vec<isize> {
    nums[start..start + k].reverse();
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 4, 5, 6], 4, 2), vec![1, 2, 3, 4, 6, 5]);
}
