fn f(st: String) -> String {
    if st.chars().next() == Some('~') {
        let e = format!("{:s<10}", st);
        return f(e);
    } else {
        return format!("{:n>10}", st);
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("eqe-;ew22")), String::from("neqe-;ew22"));
}
