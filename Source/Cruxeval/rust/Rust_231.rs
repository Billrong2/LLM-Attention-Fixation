fn f(years: Vec<isize>) -> isize {
    let a10 = years.iter().filter(|&x| *x <= 1900).count();
    let a90 = years.iter().filter(|&x| *x > 1910).count();
    
    if a10 > 3 {
        3
    } else if a90 > 3 {
        1
    } else {
        2
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1872, 1995, 1945]), 2);
}
