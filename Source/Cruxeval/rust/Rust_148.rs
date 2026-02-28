fn f(forest: String, animal: String) -> String {
    let index = forest.find(&animal).unwrap_or(0);
    let mut result: Vec<char> = forest.chars().collect();
    let mut i = index;
    while i < result.len() - 1 {
        result[i] = forest.chars().nth(i + 1).unwrap_or('-');
        i += 1;
    }
    if i == result.len() - 1 {
        result[i] = '-';
    }
    result.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("2imo 12 tfiqr."), String::from("m")), String::from("2io 12 tfiqr.-"));
}
