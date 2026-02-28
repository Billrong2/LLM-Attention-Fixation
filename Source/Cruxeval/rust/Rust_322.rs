fn f(mut chemicals: Vec<String>, num: isize) -> Vec<String> {
    let mut fish = chemicals[1..].to_vec();
    chemicals.reverse();
    for _ in 0..num {
        fish.push(chemicals.remove(1));
    }
    chemicals.reverse();
    return chemicals;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("lsi"), String::from("s"), String::from("t"), String::from("t"), String::from("d")], 0), vec![String::from("lsi"), String::from("s"), String::from("t"), String::from("t"), String::from("d")]);
}
