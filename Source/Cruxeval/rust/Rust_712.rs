fn f(text: String) -> Vec<Vec<String>> {
    let mut created: Vec<Vec<String>> = Vec::new();
    
    for line in text.lines() {
        if line == "" {
            break;
        }
        let mut line_vec: Vec<String> = line.chars().map(|c| c.to_string()).collect();
        line_vec.reverse();
        line_vec.truncate(1);
        created.push(line_vec);
    }
    
    created.reverse();
    created
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("A(hiccup)A")), vec![vec![String::from("A")]]);
}
