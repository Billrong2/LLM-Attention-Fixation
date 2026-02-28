fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut nums = nums;
    let count = nums.len();
    for i in 0..count / 2 {
        nums.swap(i, count - i - 1);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 6, 1, 3, 1]), vec![1, 3, 1, 6, 2]);
}
