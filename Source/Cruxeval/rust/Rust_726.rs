fn f(text: String) -> (isize, isize) {
    let mut ws = 0;
    for s in text.chars() {
        if s.is_whitespace() {
            ws += 1;
        }
    }
    (ws, text.len() as isize)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jcle oq wsnibktxpiozyxmopqkfnrfjds")), (2, 34));
}
