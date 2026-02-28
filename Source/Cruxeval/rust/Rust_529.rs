fn f(array: Vec<isize>) -> Vec<isize> {
    let mut prev = array[0];
    let mut new_array = array.clone();
    let mut i = 1;
    while i < new_array.len() {
        if prev != new_array[i] {
            new_array[i] = new_array[i];
        } else {
            new_array.remove(i);
        }
        prev = new_array[i];
        i += 1;
    }
    new_array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3]), vec![1, 2, 3]);
}
