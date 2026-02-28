fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut result = nums.clone();
    
    for i in 0..nums.len() {
        if i % 2 == 0 {
            result.push(nums[i] * nums[i + 1]);
        }
    }
    
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
