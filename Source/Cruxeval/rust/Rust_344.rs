fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut new_list = lst.clone();
    new_list.sort_by(|a, b| b.cmp(a));
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 4, 2, 8, 15]), vec![6, 4, 2, 8, 15]);
}
