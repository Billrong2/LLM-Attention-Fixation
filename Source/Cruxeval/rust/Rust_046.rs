fn f(l: Vec<String>, c: String) -> String {
    l.join(&c)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("many"), String::from("letters"), String::from("asvsz"), String::from("hello"), String::from("man")], String::from("")), String::from("manylettersasvszhelloman"));
}
