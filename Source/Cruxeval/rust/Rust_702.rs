fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut nums = nums;
    let count = nums.len();
    for i in (0..nums.len()).rev() {
        let removed = nums.remove(0);
        nums.insert(i, removed);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, -5, -4]), vec![-4, -5, 0]);
}
