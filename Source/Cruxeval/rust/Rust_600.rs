fn f(array: Vec<isize>) -> Vec<String> {
    let just_ns: Vec<String> = array.iter().map(|&num| "n".repeat(num as usize)).collect();
    let mut final_output: Vec<String> = vec![];
    for wipe in just_ns {
        final_output.push(wipe);
    }
    final_output
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<String>::new());
}
