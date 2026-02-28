fn f(array: Vec<isize>) -> Vec<isize> {
    let mut a: Vec<isize> = vec![];
    let mut array = array;
    array.reverse();
    for &num in &array {
        if num != 0 {
            a.push(num);
        }
    }
    a.reverse();
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
