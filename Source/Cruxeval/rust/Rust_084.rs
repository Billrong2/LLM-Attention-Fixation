fn f(text: String) -> String {
    let mut arr = text.split_whitespace();
    let mut result = Vec::new();
    for item in arr {
        let modified_item = if item.ends_with("day") {
            format!("{}{}", item, "y")
        } else {
            format!("{}{}", item, "day")
        };
        result.push(modified_item);
    }
    result.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("nwv mef ofme bdryl")), String::from("nwvday mefday ofmeday bdrylday"));
}
