fn f(alphabet: String, s: String) -> Vec<String> {
    let mut a: Vec<String> = alphabet.chars()
        .filter(|&x| s.contains(x.to_ascii_uppercase()))
        .map(|x| x.to_string())
        .collect();

    if s.to_ascii_uppercase() == s {
        a.push(String::from("all_uppercased"));
    }

    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abcdefghijklmnopqrstuvwxyz"), String::from("uppercased # % ^ @ ! vz.")), Vec::<String>::new());
}
