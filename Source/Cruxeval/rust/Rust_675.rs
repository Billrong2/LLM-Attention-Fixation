fn f(nums: Vec<isize>, sort_count: isize) -> Vec<isize> {
    let mut nums = nums;
    nums.sort_unstable();
    nums.truncate(sort_count as usize);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 2, 3, 4, 5], 1), vec![1]);
}
