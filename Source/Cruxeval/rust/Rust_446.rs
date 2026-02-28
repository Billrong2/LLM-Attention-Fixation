fn f(mut array: Vec<isize>) -> Vec<isize> {
    let l = array.len();
    if l % 2 == 0 {
        array.clear();
    } else {
        array.reverse();
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
