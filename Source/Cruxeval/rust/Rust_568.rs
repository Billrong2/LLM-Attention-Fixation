fn f(num: String) -> String {
    let mut num = num;
    let mut letter = 1;
    let numbers = "1234567890";
    for i in numbers.chars() {
        num = num.replacen(&i.to_string(), "", std::usize::MAX);
        if num.len() == 0 {
            break;
        }
        let split_point = letter.min(num.len());
        let (first_part, rest_part) = num.split_at(split_point);
        num = rest_part.to_string() + first_part;
        letter += 1;
    }
    num
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bwmm7h")), String::from("mhbwm"));
}
