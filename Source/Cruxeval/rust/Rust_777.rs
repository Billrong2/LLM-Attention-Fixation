fn f(names: Vec<String>, excluded: String) -> Vec<String> {
    let mut names = names;
    let excluded = excluded;
    
    for name in names.iter_mut() {
        if name.contains(&excluded) {
            *name = name.replace(&excluded, "");
        }
    }
    
    names
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("avc  a .d e")], String::from("")), vec![String::from("avc  a .d e")]);
}
