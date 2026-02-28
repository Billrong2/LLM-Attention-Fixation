fn f(nums: Vec<isize>) -> bool {
    nums.iter().rev().eq(nums.iter())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 3, 6, 2]), false);
}
