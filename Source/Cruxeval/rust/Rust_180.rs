fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let mut a = -1;
    let mut b = nums[1..].to_vec();
    while a <= b[0] {
        nums.retain(|&x| x != b[0]);
        a = 0;
        b = b[1..].to_vec();
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, 5, 3, -2, -6, 8, 8]), vec![-1, -2, -6, 8, 8]);
}
