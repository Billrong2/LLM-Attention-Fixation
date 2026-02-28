fn f(s: String, characters: Vec<isize>) -> Vec<String> {
    characters.iter().map(|i| s.chars().nth(*i as usize).unwrap().to_string()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("s7 6s 1ss"), vec![1, 3, 6, 1, 2]), vec![String::from("7"), String::from("6"), String::from("1"), String::from("7"), String::from(" ")]);
}
