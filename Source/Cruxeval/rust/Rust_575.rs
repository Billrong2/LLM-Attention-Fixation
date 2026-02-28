fn f(nums: Vec<isize>, val: isize) -> isize {
    let mut new_list = vec![];
    for i in &nums {
        for _ in 0..val {
            new_list.push(*i);
        }
    }
    new_list.iter().sum()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![10, 4], 3), 42);
}
