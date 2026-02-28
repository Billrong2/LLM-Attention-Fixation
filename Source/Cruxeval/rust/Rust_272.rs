fn f(mut base_list: Vec<isize>, nums: Vec<isize>) -> Vec<isize> {
    base_list.extend(&nums);
    let mut res = base_list.clone();
    for i in -((nums.len() as isize))..0 {
        res.push(res[(res.len() as isize + i) as usize]);
    }
    res
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![9, 7, 5, 3, 1], vec![2, 4, 6, 8, 0]), vec![9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6]);
}
