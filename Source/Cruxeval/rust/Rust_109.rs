fn f(mut nums: Vec<isize>, spot: usize, idx: isize) -> Vec<isize> {
    nums.insert(spot, idx);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 0, 1, 1], 0, 9), vec![9, 1, 0, 1, 1]);
}
