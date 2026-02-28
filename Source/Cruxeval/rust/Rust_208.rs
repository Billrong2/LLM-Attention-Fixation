fn f(items: Vec<String>) -> Vec<String> {
    let mut result = Vec::new();
    
    for item in items {
        for d in item.chars() {
            if !d.is_digit(10) {
                result.push(d.to_string());
            }
        }
    }
    
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("123"), String::from("cat"), String::from("d dee")]), vec![String::from("c"), String::from("a"), String::from("t"), String::from("d"), String::from(" "), String::from("d"), String::from("e"), String::from("e")]);
}
