fn f(mut nums: Vec<isize>) -> String {
    nums.clear();
    String::from("quack")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 5, 1, 7, 9, 3]), String::from("quack"));
}
