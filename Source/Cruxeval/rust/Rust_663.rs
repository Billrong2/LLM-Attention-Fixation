use std::ops::Range;

fn f(container: Vec<isize>, cron: isize) -> Vec<isize> {
    if !container.contains(&cron) {
        return container;
    }
    let index = container.iter().position(|&x| x == cron).unwrap();
    let pref = &container[..index];
    let suff = &container[index + 1..];
    let mut result = pref.to_vec();
    result.extend_from_slice(suff);
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new(), 2), Vec::<isize>::new());
}
