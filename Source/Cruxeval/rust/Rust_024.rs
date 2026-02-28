fn f(mut nums: Vec<isize>, i: usize) -> Vec<isize> {
    nums.remove(i);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![35, 45, 3, 61, 39, 27, 47], 0), vec![45, 3, 61, 39, 27, 47]);
}
