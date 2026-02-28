fn f(text: String, to_replace: String) -> String {
    text.replace(&to_replace, "")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Chris requires a ride to the airport on Friday."), String::from("a")), String::from("Chris requires  ride to the irport on Fridy."));
}
