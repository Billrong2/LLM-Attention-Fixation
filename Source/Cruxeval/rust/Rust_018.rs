fn f(mut array: Vec<isize>, elem: isize) -> Vec<isize> {
    let mut k = 0;
    let l = array.clone();
    for i in &l {
        if *i > elem {
            array.insert(k, elem);
            break;
        }
        k += 1;
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, 4, 3, 2, 1, 0], 3), vec![3, 5, 4, 3, 2, 1, 0]);
}
