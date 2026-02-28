fn f(mut nums: Vec<isize>) -> Vec<isize> {
    for _ in 0..nums.len() - 1 {
        nums.reverse();
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, -9, 7, 2, 6, -3, 3]), vec![1, -9, 7, 2, 6, -3, 3]);
}
