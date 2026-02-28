fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let count = nums.len();
    if count == 0 {
        nums = vec![0; nums.pop().unwrap_or(0) as usize];
    } else if count % 2 == 0 {
        nums.clear();
    } else {
        nums.drain(..count/2);
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-6, -2, 1, -3, 0, 1]), Vec::<isize>::new());
}
