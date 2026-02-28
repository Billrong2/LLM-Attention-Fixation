fn f(array: Vec<isize>) -> Vec<isize> {
    let mut array = array;
    while array.contains(&-1) {
        array.remove(array.iter().position(|&x| x == -1).unwrap_or(0));
    }
    while array.contains(&0) {
        array.pop();
    }
    while array.contains(&1) {
        array.remove(array.iter().position(|&x| x == 1).unwrap_or(0));
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 2]), Vec::<isize>::new());
}
