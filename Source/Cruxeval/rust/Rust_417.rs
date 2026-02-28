fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut lst = lst;
    lst.reverse();
    lst.pop();
    lst.reverse();
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![7, 8, 2, 8]), vec![8, 2, 8]);
}
