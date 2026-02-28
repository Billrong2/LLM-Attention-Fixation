fn f(lines: Vec<String>) -> Vec<String> {
    let max_len = lines.iter().map(|line| line.len()).max().unwrap_or(0);
    lines.iter().map(|line| {
        let padding = max_len - line.len();
        let left_padding = padding / 2;
        let right_padding = padding - left_padding;
        format!("{}{}{}", " ".repeat(left_padding), line, " ".repeat(right_padding))
    }).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("dZwbSR"), String::from("wijHeq"), String::from("qluVok"), String::from("dxjxbF")]), vec![String::from("dZwbSR"), String::from("wijHeq"), String::from("qluVok"), String::from("dxjxbF")]);
}
