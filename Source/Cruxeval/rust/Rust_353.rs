fn f(x: Vec<isize>) -> isize {
    if x.is_empty() {
        return -1;
    } else {
        let mut cache = std::collections::HashMap::new();
        for item in x {
            let count = cache.entry(item).or_insert(0);
            *count += 1;
        }
        *cache.values().max().unwrap_or(&0)
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 0, 2, 2, 0, 0, 0, 1]), 4);
}
