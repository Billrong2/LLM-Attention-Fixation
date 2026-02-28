fn f(mut nums: Vec<isize>, mos: Vec<isize>) -> bool {
    for num in mos.iter() {
        nums.retain(|&x| x != *num);
    }
    nums.sort();
    for num in mos.iter() {
        nums.push(*num);
    }
    for i in 0..nums.len()-1 {
        if nums[i] > nums[i+1] {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 1, 2, 1, 4, 1], vec![1]), false);
}
