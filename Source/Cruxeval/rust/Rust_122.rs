fn f(string: String) -> String {
    if string.starts_with("Nuva") {
        string.trim_end().to_string()
    } else {
        String::from("no")
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Nuva?dlfuyjys")), String::from("Nuva?dlfuyjys"));
}
