fn f(txt: String, marker: isize) -> String {
    let mut a = Vec::new();
    let lines: Vec<&str> = txt.split('\n').collect();
    for line in lines {
        a.push(center(line, marker));
    }
    a.join("\n")
}

fn center(line: &str, width: isize) -> String {
    if width <= 0 {
        return line.to_string();
    }
    let len = line.len() as isize;
    if width <= len {
        return line.to_string();
    }
    let total_padding = width - len;
    let left_padding = total_padding / 2;
    let right_padding = total_padding - left_padding;
    format!(
        "{}{}{}",
        " ".repeat(left_padding as usize),
        line,
        " ".repeat(right_padding as usize)
    )
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("#[)[]>[^e>
 8"), -5), String::from("#[)[]>[^e>
 8"));
}
