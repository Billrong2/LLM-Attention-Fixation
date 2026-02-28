fn f(name: String) -> String {
    if name.chars().all(char::is_lowercase) {
        name.to_uppercase()
    } else {
        name.to_lowercase()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Pinneaple")), String::from("pinneaple"));
}
