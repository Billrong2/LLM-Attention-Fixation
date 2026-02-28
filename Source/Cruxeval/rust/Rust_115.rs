fn f(text: String) -> String {
    let mut res = Vec::new();
    for ch in text.as_bytes() {
        match *ch {
            61 => break,
            0 => (),
            _ => res.push(format!("{}; ", *ch).into_bytes()),
        }
    }
    format!("b'{}'", String::from_utf8(res.concat()).unwrap())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("os||agx5")), String::from("b'111; 115; 124; 124; 97; 103; 120; 53; '"));
}
