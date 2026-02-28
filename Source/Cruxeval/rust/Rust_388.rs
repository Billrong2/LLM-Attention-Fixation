fn f(text: String, characters: String) -> String {
    let mut character_list = characters.chars().collect::<Vec<char>>();
    character_list.push(' ');
    character_list.push('_');

    let mut i = 0;
    while i < text.len() && character_list.contains(&text.chars().nth(i).unwrap()){
        i += 1;
    }

    return text.chars().skip(i).collect::<String>();
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("2nm_28in"), String::from("nm")), String::from("2nm_28in"));
}
