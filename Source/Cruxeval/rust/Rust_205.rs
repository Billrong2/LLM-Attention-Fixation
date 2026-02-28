fn f(a: String) -> String {
    let mut a = a;
    for _ in 0..10 {
        let mut found_char = false;
        for (j, c) in a.chars().enumerate() {
            if c != '#' {
                a = a.split_at(j).1.to_string();
                found_char = true;
                break;
            }
        }
        if !found_char {
            a = "".to_string();
            break;
        }
    }
    while a.ends_with('#') {
        a.pop();
    }
    a
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("##fiu##nk#he###wumun##")), String::from("fiu##nk#he###wumun"));
}
