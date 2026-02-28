fn f(array: Vec<isize>, num: isize) -> Vec<isize> {
    let mut reverse = false;
    let mut array = array.clone(); // Make a deep copy of the input array

    if num < 0 {
        reverse = true;
        let num = num.abs() as usize;
        array.reverse();
        array = array.iter().cloned().cycle().take(array.len() * num).collect();
    } else {
        array.reverse();
        let l = array.len();

        if reverse {
            array.reverse();
        }
    }
    
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2], 1), vec![2, 1]);
}
