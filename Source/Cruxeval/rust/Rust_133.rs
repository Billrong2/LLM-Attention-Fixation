fn f(mut nums: Vec<isize>, elements: Vec<isize>) -> Vec<isize> {
    let mut result = vec![];
    for _ in elements {
        result.push(nums.pop().unwrap());
    }
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![7, 1, 2, 6, 0, 2], vec![9, 0, 3]), vec![7, 1, 2]);
}
