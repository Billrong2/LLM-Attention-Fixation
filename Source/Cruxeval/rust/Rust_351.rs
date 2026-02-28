fn f(text: String) -> String {
    let mut text = text;
    loop {
        if !text.contains("nnet lloP") {
            break;
        }
        text = text.replace("nnet lloP", "nnet loLp");
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a_A_b_B3 ")), String::from("a_A_b_B3 "));
}
