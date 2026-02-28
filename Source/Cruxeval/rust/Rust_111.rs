use std::collections::HashMap;

fn f(marks: HashMap<String, isize>) -> (isize, isize) {
    let mut highest = 0;
    let mut lowest = 100;
    for value in marks.values() {
        if *value > highest {
            highest = *value;
        }
        if *value < lowest {
            lowest = *value;
        }
    }
    (highest, lowest)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(String::from("x"), 67), (String::from("v"), 89), (String::from(""), 4), (String::from("alij"), 11), (String::from("kgfsd"), 72), (String::from("yafby"), 83)])), (89, 4));
}
