fn f(total: Vec<String>, arg: String) -> Vec<String> {
    let mut result = total;
    for c in arg.chars() {
        result.push(c.to_string());
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("1"), String::from("2"), String::from("3")], String::from("nammo")), vec![String::from("1"), String::from("2"), String::from("3"), String::from("n"), String::from("a"), String::from("m"), String::from("m"), String::from("o")]);
}
