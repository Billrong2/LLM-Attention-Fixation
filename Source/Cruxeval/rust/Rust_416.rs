fn f(text: String, old: String, new: String) -> String {
    let old = old.chars().collect::<Vec<char>>();
    let new = new.chars().collect::<Vec<char>>();
    let mut text = text.chars().collect::<Vec<char>>();
    let mut index = text.clone().into_iter().position(|x| old.contains(&x)).unwrap_or(0);
    while index > 0 {
        text.drain(index..index+old.len());
        text.splice(index..index, new.clone());
        index = text.clone().into_iter().position(|x| old.contains(&x)).unwrap_or(0);
    }
    text.into_iter().collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jysrhfm ojwesf xgwwdyr dlrul ymba bpq"), String::from("j"), String::from("1")), String::from("jysrhfm ojwesf xgwwdyr dlrul ymba bpq"));
}
