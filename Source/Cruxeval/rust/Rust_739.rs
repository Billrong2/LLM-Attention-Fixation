fn f(st: String, pattern: Vec<String>) -> bool {
    let mut st = st;
    for p in pattern {
        if !st.starts_with(&p) {
            return false;
        }
        st = st[p.len()..].to_string();
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("qwbnjrxs"), vec![String::from("jr"), String::from("b"), String::from("r"), String::from("qw")]), false);
}
