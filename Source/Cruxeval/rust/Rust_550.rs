fn f(mut nums: Vec<isize>) -> Vec<isize> {
    for i in 0..nums.len() {
        nums.insert(i, nums[i].pow(2));
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 4]), vec![1, 1, 1, 1, 2, 4]);
}
