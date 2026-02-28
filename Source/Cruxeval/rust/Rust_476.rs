fn f(a: String, split_on: String) -> bool {
    let t: Vec<&str> = a.split_whitespace().collect();
    let mut a: Vec<char> = vec![];
    
    for i in t {
        for j in i.chars() {
            a.push(j);
        }
    }
    
    if a.contains(&split_on.chars().next().unwrap()) {
        true
    } else {
        false
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("booty boot-boot bootclass"), String::from("k")), false);
}
