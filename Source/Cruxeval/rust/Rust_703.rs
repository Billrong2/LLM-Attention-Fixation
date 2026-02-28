fn f(text: String, char: String) -> String {
    let count = text.matches(&(char.to_owned() + &char)).count();
    text.split_at(count).1.to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("vzzv2sg"), String::from("z")), String::from("zzv2sg"));
}
