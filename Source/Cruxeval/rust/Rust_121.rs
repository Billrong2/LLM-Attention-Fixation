fn f(s: String) -> String {
    let nums: String = s.chars().filter(|c| c.is_numeric()).collect();
    
    if nums.is_empty() {
        return String::from("none");
    }

    let max_num: i32 = nums.split(',').map(|num| num.parse::<i32>().unwrap()).max().unwrap();
    
    max_num.to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("01,001")), String::from("1001"));
}
