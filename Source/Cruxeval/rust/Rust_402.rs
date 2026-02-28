use std::collections::HashMap;

fn f(n: isize, l: Vec<String>) -> HashMap<isize, isize> {
    let mut archive: HashMap<isize, isize> = HashMap::new();
    for _ in 0..n {
        archive.clear();
        for x in &l {
            archive.insert(x.parse::<isize>().unwrap() + 10, x.parse::<isize>().unwrap() * 10);
        }
    }
    archive
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(0, vec![String::from("aaa"), String::from("bbb")]), HashMap::from([]));
}
