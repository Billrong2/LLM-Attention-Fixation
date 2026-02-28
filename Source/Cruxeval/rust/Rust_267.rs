fn f(text: String, space: isize) -> String {
    if space < 0 {
        text
    } else {
        text.chars().chain(std::iter::repeat(' ').take(space as usize)).collect()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("sowpf"), -7), String::from("sowpf"));
}
