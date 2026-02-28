fn f(txt: String) -> isize {
    let mut coincidences = std::collections::HashMap::new();
    for c in txt.chars() {
        let count = coincidences.entry(c).or_insert(0);
        *count += 1;
    }
    coincidences.values().sum::<isize>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("11 1 1")), 6);
}
