fn f(mut array: Vec<isize>) -> Vec<isize> {
    let mut i = 0;
    while i < array.len() {
        if array[i] < 0 {
            array.remove(i);
        } else {
            i += 1;
        }
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
