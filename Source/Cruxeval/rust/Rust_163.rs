fn f(text: String, space_symbol: String, size: isize) -> String {
    let spaces = space_symbol.repeat(size as usize - text.len());
    text + &spaces
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("w"), String::from("))"), 7), String::from("w))))))))))))"));
}
