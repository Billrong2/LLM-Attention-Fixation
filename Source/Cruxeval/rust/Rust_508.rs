fn f(text: String, sep: String, maxsplit: isize) -> String {
    let splitted: Vec<&str> = text.rsplitn(maxsplit as usize + 1, &sep).collect();
    let length = splitted.len();
    let mut new_splitted = splitted[..length/2].to_vec();
    new_splitted.reverse();
    new_splitted.extend_from_slice(&splitted[length/2..]);
    new_splitted.join(&sep)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ertubwi"), String::from("p"), 5), String::from("ertubwi"));
}
