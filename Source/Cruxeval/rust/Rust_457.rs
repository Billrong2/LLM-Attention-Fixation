fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let mut count = (0..nums.len()).collect::<Vec<_>>();
    while let Some(i) = nums.pop() {
        if !count.is_empty() {
            count.remove(0);
        }
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 1, 7, 5, 6]), Vec::<isize>::new());
}
