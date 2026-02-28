fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut nums = nums;
    let m = *nums.iter().max().unwrap_or(&0);
    for _ in 0..m {
        nums.reverse();
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![43, 0, 4, 77, 5, 2, 0, 9, 77]), vec![77, 9, 0, 2, 5, 77, 4, 0, 43]);
}
