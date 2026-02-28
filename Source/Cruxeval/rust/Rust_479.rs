fn f(nums: Vec<isize>, pop1: isize, pop2: isize) -> Vec<isize> {
    let mut nums = nums;
    nums.remove(pop1 as usize - 1);
    nums.remove(pop2 as usize - 1);
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 5, 2, 3, 6], 2, 4), vec![1, 2, 3]);
}
