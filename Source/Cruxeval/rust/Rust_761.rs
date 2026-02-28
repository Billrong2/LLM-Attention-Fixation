fn f(array: Vec<isize>) -> Vec<isize> {
    let mut output = array.clone();
    let mut temp = output.clone();
    temp.reverse();
    for i in 0..output.len() {
        if i % 2 == 0 {
            output[i] = temp[i];
        }
    }
    output.reverse();
    output
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
