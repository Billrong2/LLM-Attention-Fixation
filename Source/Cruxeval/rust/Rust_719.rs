fn f(code: String) -> String {
    let lines = code.split(']');
    let mut result = vec![];
    let mut level = 0;
    for line in lines {
        if line.is_empty() { continue; }
        level += line.matches('{').count() as isize - line.matches('}').count() as isize;
        let mut chars = line.chars();
        let first = chars.next().unwrap();
        let rest = chars.collect::<String>();
        result.push(format!("{} {}", first, "  ".repeat(level as usize)) + &rest);
    }
    result.join("\n")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("if (x) {y = 1;} else {z = 1;}")), String::from("i f (x) {y = 1;} else {z = 1;}"));
}
