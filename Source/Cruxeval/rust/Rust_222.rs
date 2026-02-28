fn f(mess: String, char: String) -> String {
    let mut mess = mess;
    while let Some(index) = mess.rfind(&char) {
        if let Some(next_index) = mess[index + char.len()..].find(&char) {
            let new_index = index + char.len() + next_index;
            mess = mess[..index].to_string() + &mess[new_index + 1..];
        } else {
            break;
        }
    }
    mess
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("0aabbaa0b"), String::from("a")), String::from("0aabbaa0b"));
}
