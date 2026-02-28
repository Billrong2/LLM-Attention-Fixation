use std::collections::HashMap;

fn f(c: HashMap<String, isize>, st: isize, ed: isize) -> (String, String) {
    let mut d: HashMap<isize, String> = HashMap::new();
    let mut a: String = String::new();
    let mut b: String = String::new();
    
    for (x, y) in c.iter() {
        d.insert(*y, x.clone());
        if *y == st {
            a = x.clone();
        }
        if *y == ed {
            b = x.clone();
        }
    }
    
    let w = d[&st].clone();
    
    if a > b {
        (w, d[&ed].clone())
    } else {
        (d[&ed].clone(), w)
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("TEXT"), 7), (String::from("CODE"), 3)]), 7, 3), (String::from("TEXT"), String::from("CODE")));
}
