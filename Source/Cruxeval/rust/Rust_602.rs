fn f(nums: Vec<isize>, target: isize) -> isize {
    let cnt = nums.iter().filter(|&x| *x == target).count();
    cnt as isize * 2
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1], 1), 4);
}
