fn f(text: String) -> Vec<String> {
    let ls: Vec<&str> = text.split_whitespace().collect();
    let lines: Vec<&str> = ls.iter().step_by(3).map(|s| *s).collect();
    let mut res = vec![];
    for i in 0..2 {
        let ln: Vec<&str> = ls.iter().skip(1).step_by(3).map(|s| *s).collect();
        if 3 * i + 1 < ln.len() {
            res.push(ln[3 * i..3 * (i + 1)].join(" "));
        }
    }
    lines.into_iter().map(String::from).chain(res.into_iter()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("echo hello!!! nice!")), vec![String::from("echo")]);
}
