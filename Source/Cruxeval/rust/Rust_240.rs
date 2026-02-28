fn f(float_number: f64) -> String {
    let number = float_number.to_string();
    let dot = number.find('.');
    if let Some(dot) = dot {
        return format!("{}{}", &number[0..dot], &number[dot..].to_owned().replacen(" ", "0", number.len() - dot - 2 + 2)).to_string();
    }
    format!("{}.00", number)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(3.121), String::from("3.121"));
}
