fn f(text: String) -> String {
    let mut words: Vec<&str> = text.split_whitespace().collect();
    let mut results: Vec<String> = Vec::new();
    for word in words {
        let mut temp = format!("-{}", word);
        let mut temp2 = format!("{}-", word);
        let mut temp3 = text.clone();
        temp3 = temp3.replace(&temp, " ").replace(&temp2, " ");
        results.push(temp3);
    }
    results[0].trim_matches('-').to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("-stew---corn-and-beans-in soup-.-")), String::from("stew---corn-and-beans-in soup-."));
}
