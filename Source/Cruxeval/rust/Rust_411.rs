fn f(text: String, pref: String) -> bool {
    if pref.contains(',') {
        pref.split(", ")
            .any(|x| text.starts_with(x))
    } else {
        text.starts_with(&pref)
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hello World"), String::from("W")), false);
}
