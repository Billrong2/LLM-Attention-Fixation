fn f(array: Vec<isize>) -> Vec<String> {
    let mut array = array.into_iter().map(|_x| "x".to_string()).collect::<Vec<String>>();
    array.reverse();
    array.truncate(0);
    array.reverse();
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, -2, 0]), Vec::<String>::new());
}
