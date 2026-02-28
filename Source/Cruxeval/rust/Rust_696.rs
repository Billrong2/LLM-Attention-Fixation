fn f(text: String) -> isize {
    let mut s = 0;
    let chars: Vec<char> = text.chars().collect();
    for i in 1..chars.len() {
        s += text.rsplitn(i, chars[i]).next().unwrap().len();
    }
    s as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wdj")), 3);
}
