fn f(line: String) -> String {
    let mut count = 0;
    let mut a = Vec::new();
    for c in line.chars() {
        count += 1;
        if count % 2 == 0 {
            a.push(if c.is_lowercase() {
                c.to_uppercase().collect::<Vec<_>>()[0]
            } else {
                c.to_lowercase().collect::<Vec<_>>()[0]
            });
        } else {
            a.push(c);
        }
    }
    a.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("987yhNSHAshd 93275yrgSgbgSshfbsfB")), String::from("987YhnShAShD 93275yRgsgBgssHfBsFB"));
}
