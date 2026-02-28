fn f(num1: isize, num2: isize, num3: isize) -> String {
    let mut nums = vec![num1, num2, num3];
    nums.sort();
    format!("{},{},{}", nums[0], nums[1], nums[2])
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(6, 8, 8), String::from("6,8,8"));
}
