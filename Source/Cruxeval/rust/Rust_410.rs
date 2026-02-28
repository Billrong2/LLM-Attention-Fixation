fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let len = nums.len();
    for i in 0..len {
        nums.insert(i, nums[0]);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 3, -1, 1, -2, 6]), vec![1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6]);
}
