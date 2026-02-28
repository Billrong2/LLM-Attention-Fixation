fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let count = nums.len();
    for i in 0..count {
        nums.push(nums[i % 2]);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, 0, 0, 1, 1]), vec![-1, 0, 0, 1, 1, -1, 0, -1, 0, -1]);
}
