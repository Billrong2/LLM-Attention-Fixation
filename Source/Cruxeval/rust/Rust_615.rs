fn f(mut in_list: Vec<isize>, num: isize) -> isize {
    in_list.push(num);
    in_list.iter().position(|&x| x == *in_list.iter().take(in_list.len() - 1).max().unwrap()).unwrap() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, 12, -6, -2], -1), 1);
}
