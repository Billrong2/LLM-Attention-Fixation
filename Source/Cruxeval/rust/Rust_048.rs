fn f(mut names: Vec<String>) -> String {
    if names.is_empty() {
        return String::new();
    }
    let mut smallest = names[0].clone();
    for name in names.iter().skip(1) {
        if name < &smallest {
            smallest = name.clone();
        }
    }
    names.retain(|x| x != &smallest);
    smallest
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<String>::new()), String::from(""));
}
