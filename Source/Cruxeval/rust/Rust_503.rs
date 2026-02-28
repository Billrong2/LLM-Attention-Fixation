use std::collections::HashMap;

fn f(d: HashMap<isize, isize>) -> Vec<isize> {
    let mut result: Vec<Option<(isize, isize)>> = vec![None; d.len()];
    let mut d = d;
    let mut a = 0;
    let mut b = 0;
    while !d.is_empty() {
        let (key, value) = d.drain().nth(a).unwrap();
        result[b] = Some((key, value));
        a = b;
        b = (b + 1) % result.len();
    }
    result.into_iter().map(|x| x.unwrap().1).collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), Vec::<isize>::new());
}
