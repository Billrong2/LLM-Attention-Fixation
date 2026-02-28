fn f(values: Vec<String>) -> Vec<String> {
    let mut names = vec!["Pete".to_string(), "Linda".to_string(), "Angela".to_string()];
    names.extend(values.iter().cloned());
    names.sort();
    names
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("Dan"), String::from("Joe"), String::from("Dusty")]), vec![String::from("Angela"), String::from("Dan"), String::from("Dusty"), String::from("Joe"), String::from("Linda"), String::from("Pete")]);
}
