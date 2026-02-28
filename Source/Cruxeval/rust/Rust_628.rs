fn f(nums: Vec<isize>, delete: isize) -> Vec<isize> {
    let mut nums = nums;
    if let Some(index) = nums.iter().position(|&x| x == delete) {
        nums.remove(index);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![4, 5, 3, 6, 1], 5), vec![4, 3, 6, 1]);
}
