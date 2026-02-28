fn f(s: String, char: String) -> String {
    let base = char.repeat(s.matches(&char).count() + 1);
    s.trim_end_matches(&base).to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mnmnj krupa...##!@#!@#$$@##"), String::from("@")), String::from("mnmnj krupa...##!@#!@#$$@##"));
}
