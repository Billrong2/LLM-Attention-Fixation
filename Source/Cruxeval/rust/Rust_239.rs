fn f(text: String, froms: String) -> String {
    let trim_chars: Vec<char> = froms.chars().collect();
    let trimmed_left = text.trim_start_matches(|c| trim_chars.contains(&c)).to_string();
    trimmed_left.trim_end_matches(|c| trim_chars.contains(&c)).to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("0 t 1cos "), String::from("st 0	
  ")), String::from("1co"));
}
