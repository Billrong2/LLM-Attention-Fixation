fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut nums = nums;
    nums.sort();
    let n = nums.len();
    let mut new_nums = vec![nums[n/2]];

    if n % 2 == 0 {
        new_nums = vec![nums[n/2 - 1], nums[n/2]];
    }

    for i in 0..n/2 {
        new_nums.insert(0, nums[n-i-1]);
        new_nums.push(nums[i]);
    }

    new_nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1]), vec![1]);
}
