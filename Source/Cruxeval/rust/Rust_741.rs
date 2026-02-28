fn f(nums: Vec<isize>, p: isize) -> isize {
    let prev_p = if p > 0 { p - 1 } else { nums.len() as isize - 1 };
    nums[prev_p as usize]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 8, 2, 5, 3, 1, 9, 7], 6), 1);
}
