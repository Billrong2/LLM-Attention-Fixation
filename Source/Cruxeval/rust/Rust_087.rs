fn f(mut nums: Vec<isize>) -> String {
    nums.reverse();
    nums.iter().map(|x| x.to_string()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, 9, 3, 1, -2]), String::from("-2139-1"));
}
