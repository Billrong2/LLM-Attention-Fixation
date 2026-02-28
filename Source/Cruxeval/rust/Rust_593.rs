fn f(nums: Vec<isize>, n: isize) -> Vec<isize> {
    let len = nums.len();
    let mut new_nums = Vec::with_capacity(len * 2);
    new_nums.extend(&nums);
    new_nums.extend(&nums[0..len]);
    new_nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new(), 14), Vec::<isize>::new());
}
