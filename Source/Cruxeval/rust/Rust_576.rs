fn f(array: Vec<isize>, const_val: isize) -> Vec<String> {
    let mut output: Vec<String> = vec![String::from("x")];
    for i in 1..=array.len() {
        if i % 2 != 0 {
            output.push((array[i - 1] * -2).to_string());
        } else {
            output.push(const_val.to_string());
        }
    }
    output
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3], -1), vec![String::from("x"), String::from("-2"), String::from("-1"), String::from("-6")]);
}
