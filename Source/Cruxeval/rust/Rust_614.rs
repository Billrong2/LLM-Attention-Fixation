fn f(text: String, substr: String, occ: isize) -> isize {
    let mut n = 0;
    let mut text = text;
    loop {
        if let Some(pos) = text.rfind(&substr) {
            if n == occ {
                return pos as isize;
            } else {
                n += 1;
                text = text[..pos].to_string();
            }
        } else {
            break;
        }
    }
    -1
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("zjegiymjc"), String::from("j"), 2), -1);
}
