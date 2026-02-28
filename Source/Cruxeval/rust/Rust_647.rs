fn f(text: String, chunks: isize) -> Vec<String> {
    text.lines().map(|line| line.to_string()).collect::<Vec<String>>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("/alcm@ an)t//eprw)/e!/d
ujv"), 0), vec![String::from("/alcm@ an)t//eprw)/e!/d"), String::from("ujv")]);
}
