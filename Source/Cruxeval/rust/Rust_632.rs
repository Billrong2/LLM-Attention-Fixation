fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut lst = lst;
    for i in (1..lst.len()).rev() {
        for j in 0..i {
            if lst[j] > lst[j + 1] {
                lst.swap(j, j + 1);
            }
        }
    }
    lst.sort();
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![63, 0, 1, 5, 9, 87, 0, 7, 25, 4]), vec![0, 0, 1, 4, 5, 7, 9, 25, 63, 87]);
}
