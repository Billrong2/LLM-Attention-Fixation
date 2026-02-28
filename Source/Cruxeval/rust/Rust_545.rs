fn f(mut array: Vec<isize>) -> Vec<isize> {
    let mut result = Vec::new();
    let mut index = 0;
    while index < array.len() {
        result.push(array.pop().unwrap());
        index += 2;
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![8, 8, -4, -9, 2, 8, -1, 8]), vec![8, -1, 8]);
}
