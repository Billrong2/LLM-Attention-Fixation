use std::iter::repeat;

fn f(string: String, numbers: Vec<isize>) -> String {
    let mut arr = Vec::new();
    for num in numbers {
        let mut s = string.clone();
        if num as usize > s.len() {
            let padding = num as usize - s.len();
            s.insert_str(0, &repeat('0').take(padding).collect::<String>());
        }
        arr.push(s)
    }
    arr.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("4327"), vec![2, 8, 9, 2, 7, 1]), String::from("4327 00004327 000004327 4327 0004327 4327"));
}
