fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let mut i = nums.len() as isize - 1;
    while i >= 0 {
        if nums[i as usize] % 2 == 0 {
            nums.remove(i as usize);
        }
        i -= 1;
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, 3, 3, 7]), vec![5, 3, 3, 7]);
}
