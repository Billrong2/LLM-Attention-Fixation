fn f(strs: String) -> String {
    let mut strs: Vec<String> = strs.split_whitespace().map(|s| s.to_owned()).collect();
    for i in (1..strs.len()).step_by(2) {
        strs[i] = strs[i].chars().rev().collect();
    }
    strs.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("K zBK")), String::from("K KBz"));
}
