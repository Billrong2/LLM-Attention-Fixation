fn f(text: String, m: isize, n: isize) -> String {
    let mut text = format!("{}{}{}", text, &text[..m as usize], &text[n as usize..]);
    let mut result = String::new();
    for i in (n as usize..text.len()-m as usize).rev() {
        result.push(text.chars().nth(i).unwrap());
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abcdefgabc"), 1, 2), String::from("bagfedcacbagfedc"));
}
