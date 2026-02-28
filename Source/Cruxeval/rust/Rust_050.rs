fn f(mut lst: Vec<String>) -> Vec<isize> {
    lst.clear();
    lst.resize(lst.len() + 1, String::from("1"));
    vec![1; lst.len()]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("a"), String::from("c"), String::from("v")]), vec![1]);
}
