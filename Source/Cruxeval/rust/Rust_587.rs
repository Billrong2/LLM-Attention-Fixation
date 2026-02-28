use std::collections::HashMap;

fn f(nums: Vec<isize>, fill: String) -> HashMap<isize, String> {
    let mut ans = HashMap::new();
    for &n in &nums {
        ans.insert(n, fill.clone());
    }
    ans
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 1, 1, 2], String::from("abcca")), HashMap::from([(0, String::from("abcca")), (1, String::from("abcca")), (2, String::from("abcca"))]));
}
