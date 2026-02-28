fn f(text: String) -> Vec<isize> {
    let mut occ: std::collections::HashMap<char, isize> = std::collections::HashMap::new();
    for ch in text.chars() {
        let name = match ch {
            'a' => 'b',
            'b' => 'c',
            'c' => 'd',
            'd' => 'e',
            'e' => 'f',
            _ => ch,
        };
        let count = occ.entry(name).or_insert(0);
        *count += 1;
    }
    occ.values().cloned().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("URW rNB")), vec![1, 1, 1, 1, 1, 1, 1]);
}
