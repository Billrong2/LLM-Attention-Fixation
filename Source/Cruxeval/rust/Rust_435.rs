fn f(numbers: Vec<String>, num: usize, val: isize) -> String {
    let mut numbers = numbers;
    if num < 2 {
        return String::new();
    }
    while numbers.len() < num {
        numbers.insert(numbers.len() / 2, val.to_string());
    }
    for _ in 0..(numbers.len() / (num - 1) - 4) {
        numbers.insert(numbers.len() / 2, val.to_string());
    }
    numbers.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<String>::new(), 0, 1), String::from(""));
}
