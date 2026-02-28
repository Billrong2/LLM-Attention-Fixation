use std::str::FromStr;

fn f(string: String, code: String) -> String {
    match std::str::from_utf8(&string.into_bytes()) {
        Ok(t) if t.ends_with('\n') => {
            let t = t[0..t.len() - 1].to_string();
            match String::from_str(&t) {
                Ok(t) => t,
                Err(_) => String::new(),
            }
        }
        Ok(t) => t.to_string(),
        Err(_) => String::new(),
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("towaru"), String::from("UTF-8")), String::from("towaru"));
}
