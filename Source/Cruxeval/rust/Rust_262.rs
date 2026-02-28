fn f(nums: Vec<isize>) -> String {
    let score = vec!["F", "E", "D", "C", "B", "A", ""];
    let mut result = Vec::new();
    for &num in nums.iter() {
        result.push(score[num as usize]);
    }
    result.join("")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![4, 5]), String::from("BA"));
}
