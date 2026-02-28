fn f(text: String) -> String {
    let mut ls: Vec<char> = text.chars().collect();
    let mut x = ls.len() as isize - 1;
    while x >= 0 {
        if ls.len() <= 1 {
            break;
        }
        if !"zyxwvutsrqponmlkjihgfedcba".contains(ls[x as usize]) {
            ls.remove(x as usize);
        }
        x -= 1;
    }
    ls.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("qq")), String::from("qq"));
}
