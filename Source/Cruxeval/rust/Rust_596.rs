fn f(txt: Vec<String>, alpha: String) -> Vec<String> {
    let mut txt = txt;
    txt.sort();
    
    if txt.iter().position(|x| x == &alpha).unwrap() % 2 == 0 {
        txt.reverse();
    }

    txt
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("8"), String::from("9"), String::from("7"), String::from("4"), String::from("3"), String::from("2")], String::from("9")), vec![String::from("2"), String::from("3"), String::from("4"), String::from("7"), String::from("8"), String::from("9")]);
}
