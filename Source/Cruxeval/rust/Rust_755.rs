fn f(replace: String, text: String, hide: String) -> String {
    let mut replace = replace;
    let mut text = text;
    while text.contains(&hide) {
        replace += "ax";
        text = text.replacen(&hide, &replace, 1);
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("###"), String::from("ph>t#A#BiEcDefW#ON#iiNCU"), String::from(".")), String::from("ph>t#A#BiEcDefW#ON#iiNCU"));
}
