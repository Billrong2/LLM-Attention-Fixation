fn f(text: String, lower: isize, upper: isize) -> bool {
    text[lower as usize..upper as usize].chars().all(|c| c.is_ascii())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("=xtanp|sugv?z"), 3, 6), true);
}
