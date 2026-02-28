fn f(li: Vec<String>) -> Vec<isize> {
    li.iter().map(|i| li.iter().filter(|&x| x == i).count() as isize).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("k"), String::from("x"), String::from("c"), String::from("x"), String::from("x"), String::from("b"), String::from("l"), String::from("f"), String::from("r"), String::from("n"), String::from("g")]), vec![1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1]);
}
