fn f(text: String) -> isize {
    let mut m = 0;
    let mut cnt = 0;
    for i in text.split_whitespace() {
        if i.len() > m {
            cnt += 1;
            m = i.len();
        }
    }
    cnt
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl")), 2);
}
