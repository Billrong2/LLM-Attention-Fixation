fn f(nums: Vec<isize>, target: isize) -> isize {
    if nums.iter().filter(|&x| *x == 0).count() > 0 {
        return 0;
    } else if nums.iter().filter(|&x| *x == target).count() < 3 {
        return 1;
    } else {
        return nums.iter().position(|&x| x == target).unwrap_or(0) as isize;
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1, 1, 2], 3), 1);
}
