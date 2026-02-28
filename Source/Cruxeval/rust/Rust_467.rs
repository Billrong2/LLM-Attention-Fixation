use std::collections::HashMap;

fn f(nums: HashMap<String, String>) -> HashMap<String, usize> {
    let mut new_dict: HashMap<String, usize> = HashMap::new();
    for (k, v) in nums {
        new_dict.insert(k, v.len());
    }
    new_dict
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), HashMap::from([]));
}
