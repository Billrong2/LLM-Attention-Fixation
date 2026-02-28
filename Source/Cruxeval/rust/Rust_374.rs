fn f(seq: Vec<String>, v: String) -> Vec<String> {
    let mut a: Vec<String> = Vec::new();
    for i in seq {
        if i.ends_with(&v) {
            a.push(i.repeat(2));
        }
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("oH"), String::from("ee"), String::from("mb"), String::from("deft"), String::from("n"), String::from("zz"), String::from("f"), String::from("abA")], String::from("zz")), vec![String::from("zzzz")]);
}
