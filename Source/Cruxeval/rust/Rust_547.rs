fn f(letters: String) -> String {
    let letters_only = letters.trim_matches(|c| c == '.' || c == ',' || c == ' ' || c == '!' || c == '?' || c == '*');
    letters_only.split(" ").collect::<Vec<&str>>().join("....").to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("h,e,l,l,o,wo,r,ld,")), String::from("h,e,l,l,o,wo,r,ld"));
}
