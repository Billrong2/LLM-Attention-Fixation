fn f(text: String, symbols: String) -> String {
    let mut count = 0;
    if !symbols.is_empty() {
        for _ in symbols.chars() {
            count += 1;
        }
        let new_text = text.repeat(count);
        let final_text = format!("{:>width$}", new_text, width=new_text.len() + count*2);
        final_text[0..final_text.len()-2].to_string()
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(""), String::from("BC1ty")), String::from("        "));
}
