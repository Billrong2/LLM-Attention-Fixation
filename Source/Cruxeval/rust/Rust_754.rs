fn f(nums: Vec<String>) -> Vec<String> {
    let width = nums[0].parse::<usize>().unwrap();
    let result: Vec<String> = nums[1..].iter().map(|val| format!("{:0>width$}", val, width = width)).collect();
    result.iter().map(|val| val.to_string()).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("1"), String::from("2"), String::from("2"), String::from("44"), String::from("0"), String::from("7"), String::from("20257")]), vec![String::from("2"), String::from("2"), String::from("44"), String::from("0"), String::from("7"), String::from("20257")]);
}
