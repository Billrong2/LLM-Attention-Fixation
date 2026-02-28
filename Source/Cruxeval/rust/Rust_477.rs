fn f(text: String) -> (String, String) {
    let mut splitted: Vec<&str> = text.splitn(2, '|').collect();
    let topic = splitted.remove(0).to_string();
    let problem = match splitted.pop() {
        Some(x) => x.to_string(),
        None => "".to_string(),
    };
    if problem == "r" {
        let topic = topic.replace("u", "p");
        return (topic, problem);
    } else {
        return (topic, problem);
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("|xduaisf")), (String::from(""), String::from("xduaisf")));
}
