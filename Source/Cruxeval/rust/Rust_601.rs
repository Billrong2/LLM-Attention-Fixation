fn f(text: String) -> String {
    let t = 5;
    let mut tab: Vec<String> = Vec::new();
    
    for i in text.chars() {
        if i.to_lowercase().next().unwrap() == 'a' || i.to_lowercase().next().unwrap() == 'e' || i.to_lowercase().next().unwrap() == 'i' || i.to_lowercase().next().unwrap() == 'o' || i.to_lowercase().next().unwrap() == 'u' || i.to_lowercase().next().unwrap() == 'y' {
            tab.push(i.to_uppercase().to_string().repeat(t));
        } else {
            tab.push(i.to_string().repeat(t));
        }
    }
    
    tab.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("csharp")), String::from("ccccc sssss hhhhh AAAAA rrrrr ppppp"));
}
