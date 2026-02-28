fn f(mut nums: Vec<isize>) -> Vec<isize> {
    nums.clear();
    let mut result: Vec<isize> = Vec::new();
    for num in nums {
        result.push(num * 2);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![4, 3, 2, 1, 2, -1, 4, 2]), Vec::<isize>::new());
}
