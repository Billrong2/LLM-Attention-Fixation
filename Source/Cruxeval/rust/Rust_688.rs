fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut l: Vec<isize> = Vec::new();
    for &i in nums.iter() {
        if !l.contains(&i) {
            l.push(i);
        }
    }
    l
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 1, 9, 0, 2, 0, 8]), vec![3, 1, 9, 0, 2, 8]);
}
