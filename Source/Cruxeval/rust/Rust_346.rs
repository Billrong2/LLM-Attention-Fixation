fn f(filename: String) -> bool {
    let suffix = filename.split('.').last().unwrap_or_default();
    let f2 = format!("{}{}", filename, suffix.chars().rev().collect::<String>());
    f2.ends_with(suffix)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("docs.doc")), false);
}
