fn f(s: String, n: usize) -> Vec<String> {
    let mut ls: Vec<&str> = s.split_whitespace().collect();
    let mut out: Vec<String> = Vec::new();
    while ls.len() >= n {
        out.extend(ls.drain(ls.len() - n..).collect::<Vec<&str>>().into_iter().map(|s| s.to_string()).collect::<Vec<String>>());
    }
    let out_str: String = out.join("_");
    ls.push(&out_str);
    ls.into_iter().map(|s| s.to_string()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("one two three four five"), 3), vec![String::from("one"), String::from("two"), String::from("three_four_five")]);
}
