fn f(text: String) -> String {
    text.replace("\n", "\t")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("apples
	
pears
	
bananas")), String::from("apples			pears			bananas"));
}
