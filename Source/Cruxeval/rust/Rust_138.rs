fn f(mut text: String, chars: String) -> String {
    let mut listchars = chars.chars().collect::<Vec<char>>();
    listchars.pop(); // Discard the last character
    for i in listchars {
        let index = text.find(i).unwrap();
        text = text[..index].to_string() + &i.to_string() + &text[index + 1..].to_string();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("tflb omn rtt"), String::from("m")), String::from("tflb omn rtt"));
}
