fn f(items: Vec<String>, target: String) -> isize {
    if items.contains(&target) {
        return items.iter().position(|x| x == &target).unwrap() as isize;
    }
    -1
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("1"), String::from("+"), String::from("-"), String::from("**"), String::from("//"), String::from("*"), String::from("+")], String::from("**")), 3);
}
