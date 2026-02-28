fn f(a: String, b: Vec<String>) -> String {
    b.join(&a)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("00"), vec![String::from("nU"), String::from(" 9 rCSAz"), String::from("w"), String::from(" lpA5BO"), String::from("sizL"), String::from("i7rlVr")]), String::from("nU00 9 rCSAz00w00 lpA5BO00sizL00i7rlVr"));
}
