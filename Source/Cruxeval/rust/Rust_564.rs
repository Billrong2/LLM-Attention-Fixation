fn f(mut lists: Vec<Vec<isize>>) -> Vec<isize> {
    let mut temp = lists[1].clone();
    lists[1].clear();
    lists[2].append(&mut temp);
    lists[0].clone()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![vec![395, 666, 7, 4], vec![], vec![4223, 111]]), vec![395, 666, 7, 4]);
}
