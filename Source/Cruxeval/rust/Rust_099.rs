fn f(text: String, sep: String, num: usize) -> String {
    let words: Vec<&str> = text.rsplitn(num+1, sep.as_str()).collect();
    words.into_iter().rev().collect::<Vec<_>>().join("___")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("aa+++bb"), String::from("+"), 1), String::from("aa++___bb"));
}
