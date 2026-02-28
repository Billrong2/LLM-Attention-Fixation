fn f(text: String) -> String {
    let mut b = Vec::new();
    for line in text.lines() {
        let c = line.replace("\t", "    ");
        b.push(c);
    }
    b.join("\n")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("			tab tab tabulates")), String::from("            tab tab tabulates"));
}
