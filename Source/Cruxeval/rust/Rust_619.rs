fn f(title: String) -> String {
    title.to_lowercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("   Rock   Paper   SCISSORS  ")), String::from("   rock   paper   scissors  "));
}
