fn f(text: String, tabsize: isize) -> String {
    text.split('\n').map(|t| t.replace("\t", &" ".repeat(tabsize as usize))).collect::<Vec<_>>().join("\n")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("	f9
	ldf9
	adf9!
	f9?"), 1), String::from(" f9
 ldf9
 adf9!
 f9?"));
}
