fn f(values: Vec<isize>, item1: isize, item2: isize) -> Vec<isize> {
    let mut result = values.clone();
    
    if *values.last().unwrap() == item2 {
        if !values[1..].contains(&values[0]) {
            result.push(values[0]);
        }
    } else if *values.last().unwrap() == item1 {
        if values[0] == item2 {
            result.push(values[0]);
        }
    }

    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1], 2, 3), vec![1, 1]);
}
