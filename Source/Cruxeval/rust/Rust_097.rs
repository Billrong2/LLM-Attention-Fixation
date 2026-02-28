fn f(mut lst: Vec<isize>) -> bool {
    lst.clear();
    for i in lst {
        if i == 3 {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 0]), true);
}
