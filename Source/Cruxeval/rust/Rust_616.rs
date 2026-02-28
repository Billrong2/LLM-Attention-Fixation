fn f(body: String) -> String {
    let mut ls: Vec<String> = body.chars().map(|c| c.to_string()).collect();
    let mut dist = 0;
    for i in 0..(ls.len() - 1) {
        if i >= 2 && ls[i - 2] == "\t" {
            dist += (1 + ls[i - 1].matches('\t').count()) * 3;
        }
        ls[i] = format!("[{}]", ls[i]);
    }
    ls.join("").replace("\t", &" ".repeat(4 + dist))
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("

y
")), String::from("[
][
][y]
"));
}
