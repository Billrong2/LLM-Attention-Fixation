fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut sorted_lst = lst.clone();
    sorted_lst.sort_unstable();
    sorted_lst.iter().take(3).cloned().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, 8, 1, 3, 0]), vec![0, 1, 3]);
}
