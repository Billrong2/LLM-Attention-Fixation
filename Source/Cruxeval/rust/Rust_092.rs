fn f(text: String) -> bool {
    text.is_ascii()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct")), false);
}
