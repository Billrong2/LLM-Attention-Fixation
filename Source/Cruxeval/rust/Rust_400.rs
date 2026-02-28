fn f(multi_string: String) -> String {
    let cond_string = multi_string.split_whitespace().map(str::is_ascii);
    if cond_string.clone().any(|x| x) {
        return multi_string.split_whitespace().filter(|x| x.is_ascii()).collect::<Vec<&str>>().join(", ");
    }
    "".to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("I am hungry! eat food.")), String::from("I, am, hungry!, eat, food."));
}
