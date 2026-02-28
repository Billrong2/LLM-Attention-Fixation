fn f(array: Vec<isize>) -> Vec<isize> {
    let mut array_2: Vec<isize> = vec![];
    for &i in array.iter() {
        if i > 0 {
            array_2.push(i);
        }
    }
    array_2.sort_unstable_by(|a, b| b.cmp(a));
    array_2
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![4, 8, 17, 89, 43, 14]), vec![89, 43, 17, 14, 8, 4]);
}
