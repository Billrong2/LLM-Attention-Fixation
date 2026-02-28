fn f(text: String, chars: String) -> String {
    let num_applies: i32 = 2;
    let mut extra_chars: String = String::new();
    let mut mutable_text = text;

    for _ in 0..num_applies {
        extra_chars.push_str(&chars);
        mutable_text = mutable_text.replace(&extra_chars, "");
    }

    mutable_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("zbzquiuqnmfkx"), String::from("mk")), String::from("zbzquiuqnmfkx"));
}
