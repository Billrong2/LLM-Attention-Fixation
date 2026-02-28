fn f(value: String) -> String {
    let parts: Vec<&str> = value.split(' ').step_by(2).collect();
    parts.join("")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("coscifysu")), String::from("coscifysu"));
}
