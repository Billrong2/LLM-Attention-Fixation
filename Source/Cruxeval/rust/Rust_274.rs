fn f(nums: Vec<isize>, target: isize) -> isize {
    let mut count = 0;
    for n1 in nums.iter() {
        for n2 in nums.iter() {
            count += (n1 + n2 == target) as isize;
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3], 4), 3);
}
