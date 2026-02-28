fn f(text: String) -> bool {
    let length = text.len();
    let half = length / 2;
    let encode = text.chars().take(half).collect::<String>().as_bytes().to_vec();
    
    if &text[half..] == String::from_utf8_lossy(&encode).to_string() {
        true
    } else {
        false
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bbbbr")), false);
}
