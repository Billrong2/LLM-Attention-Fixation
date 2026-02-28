fn f(num: isize) -> isize {
    let mut initial = vec![1];
    let mut total = initial.clone();
    
    for _ in 0..num {
        total = vec![1]
            .into_iter()
            .chain(total.iter().zip(total.iter().skip(1)).map(|(x, y)| x + y))
            .collect();
        initial.push(*total.last().unwrap());
    }
    
    initial.iter().sum()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(3), 4);
}
