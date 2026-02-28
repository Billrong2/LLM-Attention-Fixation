fn f(array: Vec<isize>, values: Vec<isize>) -> Vec<isize> {
    let mut array = array;
    array.reverse();
    for value in values {
        array.insert(array.len() / 2, value);
    }
    array.reverse();
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![58], vec![21, 92]), vec![58, 92, 21]);
}
