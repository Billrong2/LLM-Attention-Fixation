fn f(s: String) -> String {
    let mut arr: Vec<char> = s.trim().chars().collect();
    arr.reverse();
    arr.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("   OOP   ")), String::from("POO"));
}
