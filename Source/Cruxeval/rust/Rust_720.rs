fn f(items: Vec<String>, item: String) -> isize {
    let mut items = items;
    while items.last() == Some(&item.clone()) {
        items.pop();
    }
    items.push(item);
    items.len() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("bfreratrrbdbzagbretaredtroefcoiqrrneaosf")], String::from("n")), 2);
}
