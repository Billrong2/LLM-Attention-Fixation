fn f(lst: Vec<isize>, start: isize, end: isize) -> isize {
    let mut count = 0;
    for i in start..end {
        for j in i..end {
            if lst[i as usize] != lst[j as usize] {
                count += 1;
            }
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 4, 3, 2, 1], 0, 3), 3);
}
