fn f(nums: Vec<isize>) -> isize {
    let mut nums_copy = nums.clone();
    nums_copy.retain(|&x| x % 2 == 0);
    let sum_: isize = nums_copy.iter().sum();
    sum_
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![11, 21, 0, 11]), 0);
}
