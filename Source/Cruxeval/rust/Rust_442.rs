fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut res: Vec<isize> = Vec::new();
    for &num in lst.iter() {
        if num % 2 == 0 {
            res.push(num);
        }
    }
    
    return lst.clone();
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 4]), vec![1, 2, 3, 4]);
}
