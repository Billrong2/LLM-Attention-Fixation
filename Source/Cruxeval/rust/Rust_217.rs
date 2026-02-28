fn f(string: String) -> String {
    if string.chars().all(char::is_alphanumeric) {
        String::from("ascii encoded is allowed for this language")
    } else {
        String::from("more than ASCII")
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Str zahrnuje anglo-ameriæske vasi piscina and kuca!")), String::from("more than ASCII"));
}
