use std::collections::HashMap;

fn f(n: isize) -> Vec<f64> {
    let mut values = vec![(0, 3.0), (1, 4.5), (2, std::f64::NAN)];
    let mut res = HashMap::new();
    
    for (i, j) in values.iter() {
        if i % n as usize != 2 {
            res.insert(j.to_string(), n / 2);
        }
    }
    
    let mut sorted_res: Vec<f64> = res.keys().map(|k| k.parse().unwrap()).collect();
    sorted_res.sort_by(|a, b| a.partial_cmp(b).unwrap());
    
    sorted_res
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(12), vec![3.0, 4.5]);
}
