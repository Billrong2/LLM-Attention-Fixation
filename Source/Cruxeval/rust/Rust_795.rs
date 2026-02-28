fn f(text: String) -> String {
    let mut result = String::new();
    let mut capitalize_next = true;

    for c in text.chars() {
        if capitalize_next && c.is_ascii_lowercase() {
            result.push(c.to_ascii_uppercase());
        } else {
            result.push(c);
        }

        capitalize_next = !c.is_ascii_alphanumeric();
    }

    result.replace("Io", "io")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Fu,ux zfujijabji pfu.")), String::from("Fu,Ux Zfujijabji Pfu."));
}
