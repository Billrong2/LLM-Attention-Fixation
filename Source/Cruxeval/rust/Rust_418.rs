fn f(s: String, p: String) -> String {
    let arr: Vec<&str> = s.split(p.as_str()).collect();
    let part_one = arr.first().unwrap_or(&"").len();
    let part_two = arr.get(1).unwrap_or(&"").len();
    let part_three = arr.last().unwrap_or(&"").len();
    if part_one >= 2 && part_two <= 2 && part_three >= 2 {
        let part_one = arr.first().unwrap_or(&"").chars().rev().collect::<String>();
        let part_three = arr.last().unwrap_or(&"").chars().rev().collect::<String>();
        return format!("{}{}{}{}#", part_one, p, part_three, "");
    }
    return format!("{}{}{}", arr.first().unwrap_or(&""), p, arr.last().unwrap_or(&""));
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("qqqqq"), String::from("qqq")), String::from("qqqqq"));
}
