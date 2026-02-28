fn f(text: String) -> String {
    let mut g = String::new();
    let mut field = text.replace(" ", "");
    g.push_str(&text.replace("0", " "));
    let mut text = text.replace("1", "i");

    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("00000000 00000000 01101100 01100101 01101110")), String::from("00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0"));
}
