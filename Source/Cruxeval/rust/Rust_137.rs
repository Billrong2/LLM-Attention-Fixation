fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut count = 0;
    let mut nums = nums;
    
    for i in 0..nums.len() {
        if nums.is_empty() {
            break;
        }
        if count % 2 == 0 {
            nums.pop();
        } else {
            nums.remove(0);
        }
        count += 1;
    }
    
    nums
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 2, 0, 0, 2, 3]), Vec::<isize>::new());
}
