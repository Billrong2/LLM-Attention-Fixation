fn f(array: Vec<isize>, target: isize) -> isize {
    let mut count = 0;
    let mut i = 1;
    
    for j in 1..array.len() {
        if array[j] > array[j-1] && array[j] <= target {
            count += i;
        } else if array[j] <= array[j-1] {
            i = 1;
        } else {
            i += 1;
        }
    }
    
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, -1, 4], 2), 1);
}
