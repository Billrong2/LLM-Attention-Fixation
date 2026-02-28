fn f(start: isize, end: isize, interval: isize) -> isize {
    let mut steps = (start..=end).step_by(interval as usize).collect::<Vec<isize>>();
    if steps.contains(&1) {
        *steps.last_mut().unwrap() = end + 1;
    }
    steps.len() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(3, 10, 1), 8);
}
