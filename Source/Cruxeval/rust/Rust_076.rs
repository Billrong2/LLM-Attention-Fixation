fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut nums = nums.iter().cloned().filter(|&y| y > 0).collect::<Vec<isize>>();
    if nums.len() <= 3 {
        return nums;
    }
    nums.reverse();
    let half = nums.len() / 2;
    let mut result = Vec::new();
    result.extend_from_slice(&nums[..half]);
    result.extend(vec![0; 5]);
    result.extend_from_slice(&nums[half..]);
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![10, 3, 2, 2, 6, 0]), vec![6, 2, 0, 0, 0, 0, 0, 2, 3, 10]);
}
