fn f(value: String) -> String {
    let mut ls = value.chars().collect::<Vec<char>>();
    ls.push('N');
    ls.push('H');
    ls.push('I');
    ls.push('B');
    ls.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ruam")), String::from("ruamNHIB"));
}
