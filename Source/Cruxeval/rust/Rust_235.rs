fn f(array: Vec<String>, arr: Vec<String>) -> Vec<String> {
    let mut result = Vec::new();
    for s in &arr {
        let index = array.iter().position(|x| x == s).unwrap();
        let split_arr: Vec<&str> = s.split(&arr[index]).collect();
        result.extend(split_arr.into_iter().filter(|&l| l != "").map(|x| x.to_string()));
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<String>::new(), Vec::<String>::new()), Vec::<String>::new());
}
