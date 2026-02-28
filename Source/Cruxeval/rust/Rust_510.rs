use std::collections::HashMap;

fn f(a: HashMap<isize, String>, b: isize, c: String, d: String, e: f64) -> String {
    let mut a = a;
    if d.chars().next().unwrap() == '+' {
        a.remove(&d.parse().unwrap());
    }
    if b > 3 {
        c.chars().collect::<String>()
    } else {
        a.remove(&d.parse().unwrap()).unwrap()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(7, String::from("ii5p")), (1, String::from("o3Jwus")), (3, String::from("lot9L")), (2, String::from("04g")), (9, String::from("Wjf")), (8, String::from("5b")), (0, String::from("te6")), (5, String::from("flLO")), (6, String::from("jq")), (4, String::from("vfa0tW"))]), 4, String::from("Wy"), String::from("Wy"), 1.0), String::from("Wy"));
}
