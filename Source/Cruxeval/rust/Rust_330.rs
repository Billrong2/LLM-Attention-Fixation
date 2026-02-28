fn f(text: String) -> String {
    let mut ans = String::new();
    for character in text.chars() {
        if character.is_digit(10) {
            ans.push(character);
        } else {
            ans.push(' ');
        }
    }
    ans
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("m4n2o")), String::from(" 4 2 "));
}
