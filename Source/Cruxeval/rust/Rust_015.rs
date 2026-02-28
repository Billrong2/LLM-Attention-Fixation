fn f(text: String, wrong: String, right: String) -> String {
    let new_text = text.replace(&wrong, &right);
    new_text.to_uppercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("zn kgd jw lnt"), String::from("h"), String::from("u")), String::from("ZN KGD JW LNT"));
}
