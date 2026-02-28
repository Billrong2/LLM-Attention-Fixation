fn f(no: Vec<String>) -> isize {
    use std::collections::HashMap;

    let mut d: HashMap<&str, bool> = HashMap::new();
    for i in &no {
        d.insert(i, false);
    }
    
    d.keys().len() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("l"), String::from("f"), String::from("h"), String::from("g"), String::from("s"), String::from("b")]), 6);
}
