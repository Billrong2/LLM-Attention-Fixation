fn f(name: String) -> String {
    let mut new_name = String::new();
    let mut name = name.chars().rev().collect::<String>();
    for n in name.chars() {
        if n != '.' && new_name.matches('.').count() < 2 {
            new_name = n.to_string() + &new_name;
        } else {
            break;
        }
    }
    new_name
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(".NET")), String::from("NET"));
}
