fn f(text: String) -> isize {
    let mut a = 0;
    let chars: Vec<char> = text.chars().collect();
    if chars.iter().any(|&x| chars[1..].contains(&x)) {
        a += 1;
    }
    for i in 0..(chars.len() - 1) {
        if chars[i+1..].contains(&chars[i]) {
            a += 1;
        }
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("3eeeeeeoopppppppw14film3oee3")), 18);
}
