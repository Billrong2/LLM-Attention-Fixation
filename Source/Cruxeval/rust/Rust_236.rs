fn f(array: Vec<String>) -> String {
    if array.len() == 1 {
        return array[0].clone();
    }
    let mut result = array.clone();
    let mut i = 0;
    while i < array.len()-1 {
        for j in 0..2 {
            result[i*2] = array[i].clone();
            i += 1;
        }
    }
    result.join("")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("ac8"), String::from("qk6"), String::from("9wg")]), String::from("ac8qk6qk6"));
}
