fn f(fruits: Vec<String>) -> Vec<String> {
    let mut res = fruits.clone();
    if res[0] == res[res.len() - 1] {
        vec!["no".to_string()]
    } else {
        res.remove(0);
        res.pop();
        res.remove(0);
        res.pop();
        res
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("apple"), String::from("apple"), String::from("pear"), String::from("banana"), String::from("pear"), String::from("orange"), String::from("orange")]), vec![String::from("pear"), String::from("banana"), String::from("pear")]);
}
