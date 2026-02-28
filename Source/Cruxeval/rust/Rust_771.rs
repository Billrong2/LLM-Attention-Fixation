fn f(items: Vec<isize>) -> Vec<isize> {
    let mut odd_positioned: Vec<isize> = Vec::new();
    let mut items = items;
    while items.len() > 0 {
        let position = items.iter().position(|&x| x == *items.iter().min().unwrap()).unwrap();
        items.remove(position);
        let item = items.remove(position);
        odd_positioned.push(item);
    }
    odd_positioned
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 4, 5, 6, 7, 8]), vec![2, 4, 6, 8]);
}
