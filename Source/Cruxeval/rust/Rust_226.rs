fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let mut i = 0;
    let len = nums.len();
    while i < len {
        if nums[i] % 3 == 0 {
            nums.push(nums[i]);
        }
        i += 1;
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 3]), vec![1, 3, 3]);
}
