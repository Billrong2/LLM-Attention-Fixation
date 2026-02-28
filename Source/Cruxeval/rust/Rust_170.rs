fn f(nums: Vec<isize>, number: isize) -> isize {
    nums.iter().filter(|&x| *x == number).count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![12, 0, 13, 4, 12], 12), 2);
}
