fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let count = nums.len();
    for i in 0..count {
        nums.insert(i, nums[i]*2);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 8, -2, 9, 3, 3]), vec![4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3]);
}
