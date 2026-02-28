fn f(strings: Vec<String>, substr: String) -> Vec<String> {
    let mut list: Vec<String> = strings.iter().filter(|&s| s.starts_with(&substr)).cloned().collect();
    list.sort_by(|a, b| a.len().cmp(&b.len()));
    list
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("condor"), String::from("eyes"), String::from("gay"), String::from("isa")], String::from("d")), Vec::<String>::new());
}
