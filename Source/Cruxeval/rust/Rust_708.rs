fn f(string: String) -> String {
    let mut l: Vec<char> = string.chars().collect();
    let mut i = l.len();
    while i > 0 {
        i -= 1;
        if l[i] != ' ' {
            break;
        }
        l.pop();
    }
    l.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("    jcmfxv     ")), String::from("    jcmfxv"));
}
