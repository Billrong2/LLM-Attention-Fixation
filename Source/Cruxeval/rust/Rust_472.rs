fn f(text: String) -> Vec<isize> {
    use std::collections::HashMap;
    
    let mut d: HashMap<char, isize> = HashMap::new();
    
    for char in text.replace("-", "").to_lowercase().chars() {
        let count = d.entry(char).or_insert(0);
        *count += 1;
    }
    
    let mut d_vec: Vec<_> = d.into_iter().collect();
    d_vec.sort_by_key(|&(_, count)| count);
    
    d_vec.iter().map(|&(_, val)| val).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("x--y-z-5-C")), vec![1, 1, 1, 1, 1]);
}
