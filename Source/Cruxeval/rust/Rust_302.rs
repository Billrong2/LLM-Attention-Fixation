fn f(string: String) -> String {
    string.replace("needles", "haystacks")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wdeejjjzsjsjjsxjjneddaddddddefsfd")), String::from("wdeejjjzsjsjjsxjjneddaddddddefsfd"));
}
