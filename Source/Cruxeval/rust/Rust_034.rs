fn f(nums: Vec<isize>, odd1: isize, odd2: isize) -> Vec<isize> {
    let mut nums = nums;
    nums.retain(|&x| x != odd1);
    nums.retain(|&x| x != odd2);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3], 3, 1), vec![2, 7, 7, 6, 8, 4, 2, 5, 21]);
}
