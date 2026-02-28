fn f(mut nums: Vec<isize>) -> Vec<isize> {
    let count = nums.len();
    while nums.len() > count / 2 {
        nums.clear();
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 1, 2, 3, 1, 6, 3, 8]), Vec::<isize>::new());
}
