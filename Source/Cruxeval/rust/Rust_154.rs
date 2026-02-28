fn f(s: String, c: String) -> String {
    let mut s = s.split(' ');
    let reversed: Vec<&str> = s.collect();
    let reversed_str = reversed.into_iter().rev().collect::<Vec<&str>>().join("  ");
    c + "  " + &reversed_str
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hello There"), String::from("*")), String::from("*  There  Hello"));
}
