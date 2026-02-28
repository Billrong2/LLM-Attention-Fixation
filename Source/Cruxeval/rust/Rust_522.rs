fn f(numbers: Vec<isize>) -> Vec<f64> {
    let floats: Vec<f64> = numbers.iter().map(|n| (*n as f64 % 1.0)).collect();
    if floats.contains(&1.0) {
        floats
    } else {
        vec![]
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119]), Vec::<f64>::new());
}
