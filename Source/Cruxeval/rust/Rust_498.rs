fn f(mut nums: Vec<isize>, idx: usize, added: isize) -> Vec<isize> {
    nums.insert(idx, added);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 2, 2, 3, 3], 2, 3), vec![2, 2, 3, 2, 3, 3]);
}
