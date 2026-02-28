fn f(s: String) -> String {
    let mut count = s.len() - 1;
    let mut reverse_s = s.chars().rev().collect::<String>();
    while count > 0 && reverse_s.chars().step_by(2).collect::<String>().rfind("sea").is_none() {
        count -= 1;
        reverse_s = reverse_s.chars().take(count).collect();
    }
    reverse_s.chars().skip(count).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("s a a b s d s a a s a a")), String::from(""));
}
