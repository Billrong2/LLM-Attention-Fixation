fn f(text: String, tabstop: isize) -> String {
    let mut text = text.replace("\n", "_____");
    text = text.replace("\t", &" ".repeat(tabstop as usize));
    text = text.replace("_____", "\n");
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("odes	code	well"), 2), String::from("odes  code  well"));
}
