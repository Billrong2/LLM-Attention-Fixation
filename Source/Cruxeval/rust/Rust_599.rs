fn f(a: Vec<String>, b: String) -> Vec<String> {
    let mut a = a.join(&b);
    let mut lst: Vec<String> = Vec::new();
    for i in (1..=a.len()).step_by(2) {
        lst.push(a[i - 1..].chars().take(i).collect());
        lst.push(a[i - 1..].chars().skip(i).collect());
    }
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("a"), String::from("b"), String::from("c")], String::from(" ")), vec![String::from("a"), String::from(" b c"), String::from("b c"), String::from(""), String::from("c"), String::from("")]);
}
