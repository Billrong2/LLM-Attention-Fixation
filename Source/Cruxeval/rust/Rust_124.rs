fn f(txt: String, sep: String, mut sep_count: isize) -> String {
    let mut o = String::new();
    let mut txt = txt.clone();
    while sep_count > 0 && txt.matches(&sep).count() > 0 {
        let parts: Vec<&str> = txt.rsplitn(2, &sep).collect();
        o += parts[1];
        o += &sep;
        txt = parts[0].to_string();
        sep_count -= 1;
    }
    o += &txt;
    o
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("i like you"), String::from(" "), -1), String::from("i like you"));
}
