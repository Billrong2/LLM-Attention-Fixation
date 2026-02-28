fn f(string: String) -> String {
    let count = string.matches(':').count();
    let mut new_string = string.clone();
    if count > 1 {
        for _ in 0..count-1 {
            new_string = new_string.replacen(":", "", 1);
        }
    }
    new_string
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("1::1")), String::from("1:1"));
}
