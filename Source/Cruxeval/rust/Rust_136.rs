use std::iter::repeat;

fn f(text: String, width: usize) -> String {
    let lines: Vec<String> = text.split("\n").map(|line| {
        let spaces = (width.saturating_sub(line.len()) as f32 / 2.0).ceil() as usize;
        let left_spaces = spaces;
        let right_spaces = if width.saturating_sub(line.len()) % 2 == 0 { spaces } else { spaces - 1 };
        format!("{}{}{}", repeat(" ").take(left_spaces).collect::<String>(), line, repeat(" ").take(right_spaces).collect::<String>())
    }).collect();
    lines.join("\n")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a
bc

d
ef"), 5), String::from("  a  
  bc 
     
  d  
  ef "));
}
