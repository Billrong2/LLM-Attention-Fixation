fn f(nums: Vec<isize>, target: isize) -> (Vec<isize>, Vec<isize>) {
    let mut lows: Vec<isize> = Vec::new();
    let mut higgs: Vec<isize> = Vec::new();
    
    for &i in nums.iter() {
        if i < target {
            lows.push(i);
        } else {
            higgs.push(i);
        }
    }
    
    lows.clear();
    
    (lows, higgs)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![12, 516, 5, 2, 3, 214, 51], 5), (vec![], vec![12, 516, 5, 214, 51]));
}
