fn f(s: String, l: isize) -> String {
    let mut padded = s.clone();
    padded.push_str(&"=".repeat((l - s.len() as isize) as usize));
    let parts: Vec<&str> = padded.rsplitn(2, '=').collect();
    parts[1].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("urecord"), 8), String::from("urecord"));
}
