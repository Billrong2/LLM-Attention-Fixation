fn f(nums: Vec<isize>) -> Vec<isize> {
    let middle = nums.len() / 2;
    nums[middle..].iter().cloned().chain(nums[..middle].iter().cloned()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1, 1]), vec![1, 1, 1]);
}
