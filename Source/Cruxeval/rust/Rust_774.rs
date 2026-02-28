fn f(num: isize, name: String) -> String {
    let f_str = format!("quiz leader = {}, count = {}", name, num);
    f_str
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(23, String::from("Cornareti")), String::from("quiz leader = Cornareti, count = 23"));
}
