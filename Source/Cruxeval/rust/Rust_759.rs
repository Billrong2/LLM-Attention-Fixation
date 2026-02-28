use std::cmp;

fn f(text: String, sub: String) -> Vec<isize> {
    let mut index = Vec::new();
    let mut starting = 0;
    let len_sub = sub.len();
    while starting < text.len() {
        starting = text[starting..].find(&sub).unwrap_or(std::usize::MAX);
        if starting != std::usize::MAX {
            index.push(starting as isize);
            starting += len_sub;
        }
    }
    index
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("egmdartoa"), String::from("good")), Vec::<isize>::new());
}
