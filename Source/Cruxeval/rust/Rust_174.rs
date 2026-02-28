fn f(mut lst: Vec<isize>) -> Vec<isize> {
    let end = lst.len().min(4);
    lst[1..end].reverse();
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3]), vec![1, 3, 2]);
}
