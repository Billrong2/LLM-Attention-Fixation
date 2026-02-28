fn f(text: String, suffix: String) -> String {
    let mut output = text.clone();
    while output.ends_with(&suffix) {
        output = output[..output.len() - suffix.len()].to_string();
    }
    output
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("!klcd!ma:ri"), String::from("!")), String::from("!klcd!ma:ri"));
}
