fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut new: Vec<isize> = Vec::new();
    let mut i = lst.len() as isize - 1;
    
    for _ in 0..lst.len() {
        if i % 2 == 0 {
            new.push(-lst[i as usize]);
        } else {
            new.push(lst[i as usize]);
        }
        i -= 1;
    }

    new
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 7, -1, -3]), vec![-3, 1, 7, -1]);
}
