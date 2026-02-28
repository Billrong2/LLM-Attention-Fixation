fn f(st: String) -> &'static str {
    let st = st.to_lowercase();
    if let Some(i_pos) = st.rfind('i') {
        if let Some(h_pos) = st.rfind('h') {
            if h_pos >= i_pos {
                return "Hey";
            }
        }
    }
    "Hi"
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hi there")), String::from("Hey"));
}
