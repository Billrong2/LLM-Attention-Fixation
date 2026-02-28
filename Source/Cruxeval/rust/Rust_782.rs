fn f(input: String) -> bool {
    for char in input.chars() {
        if char.is_uppercase() {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a j c n x X k")), false);
}
