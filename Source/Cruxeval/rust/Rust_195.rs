fn f(text: String) -> String {
    let mut text = text;
    for p in &["acs", "asp", "scn"] {
        text = text.trim_start_matches(p).to_string() + " ";
    }
    text.trim_start().to_string()[..text.len() - 1].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ilfdoirwirmtoibsac")), String::from("ilfdoirwirmtoibsac  "));
}
