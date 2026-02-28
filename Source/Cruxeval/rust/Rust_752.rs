fn f(s: String, amount: isize) -> String {
    let z_str = "z".repeat((amount as usize).saturating_sub(s.len()));
    z_str + &s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abc"), 8), String::from("zzzzzabc"));
}
