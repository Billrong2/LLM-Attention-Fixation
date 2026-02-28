use std::collections::HashMap;

fn f(query: String, base: HashMap<String, isize>) -> isize {
    let mut net_sum = 0;
    
    for (key, val) in base.iter() {
        if key.chars().next().unwrap() == query.chars().next().unwrap() && key.len() == 3 {
            net_sum -= val;
        } else if key.chars().last().unwrap() == query.chars().next().unwrap() && key.len() == 3 {
            net_sum += val;
        }
    }
    
    net_sum
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a"), HashMap::from([])), 0);
}
