fn f(pattern: String, items: Vec<String>) -> Vec<isize> {
    let mut result = Vec::new();
    
    for text in items {
        if let Some(pos) = text.rfind(&pattern) {
            result.push(pos as isize);
        }
    }
    
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(" B "), vec![String::from(" bBb "), String::from(" BaB "), String::from(" bB"), String::from(" bBbB "), String::from(" bbb")]), Vec::<isize>::new());
}
