fn f(nums: Vec<isize>) -> isize {
    nums[nums.len() / 2]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, -3, -5, -7, 0]), -5);
}
