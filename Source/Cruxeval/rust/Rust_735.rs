fn f(sentence: String) -> String {
    let mut modified_sentence = sentence.replace("(", "").replace(")", "");
    modified_sentence = modified_sentence.replace(" ", "");
    modified_sentence = modified_sentence.to_lowercase();
    modified_sentence = modified_sentence.chars().next().unwrap().to_uppercase().collect::<String>() + &modified_sentence[1..];
    modified_sentence
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("(A (b B))")), String::from("Abb"));
}
