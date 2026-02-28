fn f(text: String, length: isize, index: isize) -> String {
    let ls: Vec<&str> = text.rsplitn(index as usize, char::is_whitespace).collect();
    ls.iter().map(|l| l.chars().take(length as usize).collect::<String>()).collect::<Vec<String>>().join("_")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hypernimovichyp"), 2, 2), String::from("hy"));
}
