fn f(x: String) -> String {
    let x_chars: Vec<char> = x.chars().collect();
    let reversed: String = x_chars.iter().rev().collect::<Vec<&char>>().iter().map(|c| c.to_string()).collect::<Vec<String>>().join(" ");
    reversed
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("lert dna ndqmxohi3")), String::from("3 i h o x m q d n   a n d   t r e l"));
}
