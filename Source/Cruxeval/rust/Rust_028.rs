fn f(mut mylist: Vec<isize>) -> bool {
    let mut revl = mylist.clone();
    revl.reverse();
    mylist.sort_by(|a, b| b.cmp(a));
    mylist == revl
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, 8]), true);
}
