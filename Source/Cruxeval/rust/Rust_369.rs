fn f(var: String) -> String {
    if var.parse::<i32>().is_ok() {
        "int".to_string()
    } else if var.replace(".", "").parse::<f64>().is_ok() {
        "float".to_string()
    } else if var.chars().all(|c| c == ' ') {
        "str".to_string()
    } else if var.len() == 1 {
        "char".to_string()
    } else {
        "tuple".to_string()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(" 99 777")), String::from("tuple"));
}
