fn f(n: String) -> String {
    let n = n.to_string();
    n.chars().take(1).collect::<String>() + "." + &n.chars().skip(1).map(|c| if c == '-' { '_' } else { c }).collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("first-second-third")), String::from("f.irst_second_third"));
}
