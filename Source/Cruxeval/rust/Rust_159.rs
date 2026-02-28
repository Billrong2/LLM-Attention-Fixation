fn f(st: String) -> String {
    let mut swapped = String::new();
    for ch in st.chars().rev() {
        if ch.is_lowercase() {
            swapped.push(ch.to_uppercase().to_string().chars().next().unwrap());
        } else {
            swapped.push(ch.to_lowercase().to_string().chars().next().unwrap());
        }
    }
    swapped
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("RTiGM")), String::from("mgItr"));
}
