fn f(input_string: String) -> String {
    let mut input_string = input_string;
    let table: std::collections::HashMap<char, char> = [('a', 'i'), ('i', 'o'), ('o', 'u'), ('e', 'a')]
        .iter()
        .cloned()
        .collect();

    while input_string.contains('a') || input_string.contains('A') {
        input_string = input_string.chars().map(|c| *table.get(&c).unwrap_or(&c)).collect();
    }

    input_string
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("biec")), String::from("biec"));
}
