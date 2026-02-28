fn f(numbers: Vec<isize>, index: isize) -> Vec<isize> {
    let mut idx = index as usize;
    let mut numbers_copy = numbers.clone();
    
    for &n in &numbers[index as usize..] {
        numbers_copy.insert(idx, n);
        idx += 1;
    }
    
    numbers_copy.truncate(idx);
    numbers_copy
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-2, 4, -4], 0), vec![-2, 4, -4]);
}
