fn f(mut nums: Vec<isize>, n: isize) -> isize {
    nums.remove(n as usize)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-7, 3, 1, -1, -1, 0, 4], 6), 4);
}
