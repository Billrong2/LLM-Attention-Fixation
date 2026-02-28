fn f(text: String) -> String {
    let mut rtext = text.chars().collect::<Vec<char>>();
    for i in 1..rtext.len() - 1 {
        rtext.insert(i + 1, '|');
    }
    rtext.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("pxcznyf")), String::from("px|||||cznyf"));
}
