fn f(text: String, char1: String, char2: String) -> String {
    let mut t1a = vec![];
    let mut t2a = vec![];

    for i in 0..char1.len() {
        t1a.push(char1.chars().nth(i).unwrap());
        t2a.push(char2.chars().nth(i).unwrap());
    }

    let t1: std::collections::HashMap<char, char> = t1a.iter().cloned().zip(t2a.iter().cloned()).collect();
    text.chars().map(|c| *t1.get(&c).unwrap_or(&c)).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ewriyat emf rwto segya"), String::from("tey"), String::from("dgo")), String::from("gwrioad gmf rwdo sggoa"));
}
