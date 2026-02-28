fn f(text: String) -> String {
    let mut ans = String::new();
    let mut text = text;
    while !text.is_empty() {
        let x = text.split_once('(').unwrap_or_else(|| ("", "")) .0;
        let sep = text.split_once('(').unwrap_or_else(|| ("", "")).1;
        ans = format!("{}{}|{}", x, ans, ans);
        text = text.chars().skip(1).collect::<String>();
        if let Some(c) = text.chars().next() {
            ans.push(c);
            ans = format!("{}{}", ans, ans);
            text = text.chars().skip(1).collect::<String>();
        }
    }
    ans
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("")), String::from(""));
}
