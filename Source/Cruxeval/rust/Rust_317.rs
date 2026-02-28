fn f(text: String, a: String, b: String) -> String {
    let text = text.replace(&a, &b);
    text.replace(&b, &a)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(" vup a zwwo oihee amuwuuw! "), String::from("a"), String::from("u")), String::from(" vap a zwwo oihee amawaaw! "));
}
