fn f(nums: Vec<isize>) -> isize {
    let mut counts = 0;
    for i in nums {
        if i.to_string().chars().all(char::is_numeric) {
            if counts == 0 {
                counts += 1;
            }
        }
    }
    counts
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 6, 2, -1, -2]), 1);
}
