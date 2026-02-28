fn f(orig: Vec<isize>) -> Vec<isize> {
    let mut copy = orig.clone();
    copy.push(100);
    copy.pop();
    copy
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3]), vec![1, 2, 3]);
}
