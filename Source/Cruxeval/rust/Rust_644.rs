fn f(mut nums: Vec<isize>, pos: isize) -> Vec<isize> {
    let mut s = 0..nums.len();
    if pos % 2 == 1 {
        s = 0..nums.len() - 1;
    }
    nums[s].reverse();
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 1], 3), vec![6, 1]);
}
