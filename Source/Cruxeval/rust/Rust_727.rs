fn f(numbers: Vec<String>, prefix: String) -> Vec<String> {
    let mut result: Vec<String> = numbers.iter()
        .map(|n| if n.len() > prefix.len() && n.starts_with(&prefix) {
            n[prefix.len()..].to_string()
        } else {
            n.to_string()
        })
        .collect();

    result.sort();

    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("ix"), String::from("dxh"), String::from("snegi"), String::from("wiubvu")], String::from("")), vec![String::from("dxh"), String::from("ix"), String::from("snegi"), String::from("wiubvu")]);
}
