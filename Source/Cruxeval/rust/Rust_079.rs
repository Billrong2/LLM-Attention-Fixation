fn f(arr: Vec<isize>) -> String {
    let mut arr = arr.clone();
    arr.clear();
    arr.push(1);
    arr.push(2);
    arr.push(3);
    arr.push(4);
    arr.iter().map(|x| x.to_string()).collect::<Vec<String>>().join(",")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 1, 2, 3, 4]), String::from("1,2,3,4"));
}
