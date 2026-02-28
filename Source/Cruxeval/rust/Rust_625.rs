fn f(text: String) -> isize {
    let mut count = 0;
    for i in text.chars() {
        if ".?!.,".contains(i) {
            count += 1;
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bwiajegrwjd??djoda,?")), 4);
}
