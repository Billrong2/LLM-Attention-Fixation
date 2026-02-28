fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let count = nums.len();
    for _num in 2..count {
        nums.sort();
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-6, -5, -7, -8, 2]), vec![-8, -7, -6, -5, 2]);
}
