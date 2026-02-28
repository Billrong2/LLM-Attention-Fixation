fn f(text: String, char: String) -> String {
    if text.contains(&char) {
        let pos = text.find(&char).unwrap();
        let (suff, pref) = text.split_at(pos + char.len());
        let suff = suff.to_string();
        let pref = pref.to_string();
        let pref = format!("{}{}", &suff[..suff.len() - char.len()], pref);
        format!("{}{}{}", suff, char, pref)
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("uzlwaqiaj"), String::from("u")), String::from("uuzlwaqiaj"));
}
