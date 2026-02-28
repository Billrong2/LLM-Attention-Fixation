fn f(n: usize) -> String {
    let mut streak = String::new();
    for c in n.to_string().chars() {
        let count = c.to_digit(10).unwrap() as usize * 2;
        streak.push(c);
        if count > 0 {
            streak.push_str(&" ".repeat(count - 1));
        }
    }
    streak
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1), String::from("1 "));
}
