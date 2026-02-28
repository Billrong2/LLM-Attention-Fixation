use std::iter::repeat;

fn f(messages: Vec<Vec<String>>) -> String {
    let phone_code = vec![String::from("+"), String::from("3"), String::from("5"), String::from("3")];
    let mut result: Vec<String> = Vec::new();
    for message in messages {
        let mut new_message = message;
        new_message.append(&mut phone_code.clone());
        result.push(new_message.join(";"));
    }
    result.join(". ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![vec![String::from("Marie"), String::from("Nelson"), String::from("Oscar")]]), String::from("Marie;Nelson;Oscar;+;3;5;3"));
}
