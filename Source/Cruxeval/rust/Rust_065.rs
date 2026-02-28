fn f(mut nums: Vec<isize>, index: isize) -> isize {
    nums[index as usize] % 42 + nums.remove(index as usize) * 2
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 2, 0, 3, 7], 3), 9);
}
