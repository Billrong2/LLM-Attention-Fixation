fn f() -> Vec<String> {
    let mut d = std::collections::HashMap::<&str, Vec<(&str, &str)>>::new();
    d.insert("Russia", vec![("Moscow", "Russia"), ("Vladivostok", "Russia")]);
    d.insert("Kazakhstan", vec![("Astana", "Kazakhstan")]);
    
    d.keys().map(|k| k.to_string()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(), vec![String::from("Russia"), String::from("Kazakhstan")]);
}
