fn f(item: String) -> String {
let modified = item.replace(". ", " , ").replace("&#33; ", "! ").replace(". ", "? ").replace(". ", ". ");
let mut chars = modified.chars();
let first_char = chars.next().unwrap().to_uppercase();
let rest_of_string: String = chars.collect();
format!("{}{}", first_char, rest_of_string)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(".,,,,,. منبت")), String::from(".,,,,, , منبت"));
}
