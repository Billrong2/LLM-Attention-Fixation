use std::collections::HashMap;

fn f(bag: HashMap<isize, isize>) -> HashMap<isize, isize> {
    let values: Vec<isize> = bag.values().cloned().collect();
    let mut tbl: HashMap<isize, isize> = HashMap::new();
    for v in 0..100 {
        if values.contains(&v) {
            let count = values.iter().filter(|&x| *x == v).count() as isize;
            tbl.insert(v, count);
        }
    }
    tbl
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([(0, 0), (1, 0), (2, 0), (3, 0), (4, 0)])), HashMap::from([(0, 5)]));
}
