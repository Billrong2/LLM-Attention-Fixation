use std::collections::HashMap;

fn f(original: HashMap<isize, isize>, string: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let mut temp = original.clone();
    for (a, b) in string {
        temp.insert(b, a);
    }
    temp
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(1, -9), (0, -7)]), HashMap::from([(1, 2), (0, 3)])), HashMap::from([(1, -9), (0, -7), (2, 1), (3, 0)]));
}
