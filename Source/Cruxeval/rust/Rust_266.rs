fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let mut i = nums.len();
    while i > 0 {
        i -= 1;
        if nums[i] % 2 == 1 {
            nums.insert(i + 1, nums[i]);
        }
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 3, 4, 6, -2]), vec![2, 3, 3, 4, 6, -2]);
}
