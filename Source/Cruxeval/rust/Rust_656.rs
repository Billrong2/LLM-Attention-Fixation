fn f(letters: Vec<String>) -> String {
    let mut a: Vec<String> = Vec::new();
    for i in 0..letters.len() {
        if a.contains(&letters[i]) {
            return String::from("no");
        }
        a.push(letters[i].clone());
    }
    String::from("yes")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("b"), String::from("i"), String::from("r"), String::from("o"), String::from("s"), String::from("j"), String::from("v"), String::from("p")]), String::from("yes"));
}
