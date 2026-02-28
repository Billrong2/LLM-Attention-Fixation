fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let mut count = 1;
    while count < nums.len() - 1 {
        nums[count] = nums[count].max(nums[count - 1]);
        count += 2;
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3]), vec![1, 2, 3]);
}
