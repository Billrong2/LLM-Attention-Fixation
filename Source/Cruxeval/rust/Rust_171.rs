fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let count = nums.len() / 2;
    for _ in 0..count {
        nums.remove(0);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 4, 1, 2, 3]), vec![1, 2, 3]);
}
