fn f(numbers: String) -> isize {
    for i in 0..numbers.len() {
        if numbers.matches('3').count() > 1 {
            return i as isize;
        }
    }
    -1
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("23157")), -1);
}
