fn f(mut list_x: Vec<isize>) -> Vec<isize> {
    let mut item_count = list_x.len();
    let mut new_list = Vec::new();
    
    while item_count > 0 {
        new_list.push(list_x.pop().unwrap());
        item_count -= 1;
    }
    
    new_list
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, 8, 6, 8, 4]), vec![4, 8, 6, 8, 5]);
}
