fn f(array: Vec<String>) -> String {
    let mut s = String::new();
    s.push_str(" ");
    s.push_str(&array.join(""));
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from(" "), String::from("  "), String::from("    "), String::from("   ")]), String::from("           "));
}
