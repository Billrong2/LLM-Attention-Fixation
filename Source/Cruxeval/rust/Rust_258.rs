fn f(L: Vec<isize>, m: isize, start: usize, step: isize) -> Vec<isize> {
    let mut new_start = start as isize;
    let mut L = L;
    L.insert(start, m);
    for _x in (start-1..0).step_by(-step as usize) {
        new_start -= 1;
        let index = L.iter().position(|&x| x == m).unwrap() - 1;
        let value = L.remove(index);
        L.insert(new_start as usize, value);
    }
    L
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 7, 9], 3, 3, 2), vec![1, 2, 7, 3, 9]);
}
