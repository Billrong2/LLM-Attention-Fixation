fn f(mut nums: Vec<isize>, pos: usize, value: isize) -> Vec<isize> {
    nums.insert(pos, value);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 1, 2], 2, 0), vec![3, 1, 0, 2]);
}
