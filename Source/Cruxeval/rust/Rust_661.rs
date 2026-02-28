fn f(letters: String, maxsplit: usize) -> String {
    let words: Vec<&str> = letters.split_whitespace().collect();
    let len = words.len();
    let start = if len > maxsplit { len - maxsplit } else { 0 };
    words[start..len].join("")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("elrts,SS ee"), 6), String::from("elrts,SSee"));
}
