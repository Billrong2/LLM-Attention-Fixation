fn f(lst: Vec<isize>) -> Vec<isize> {
    let mut i = 0;
    let mut new_list = vec![];
    
    while i < lst.len() {
        if lst[i] == lst[i+1..].iter().cloned().find(|&x| x == lst[i]).unwrap_or(0) {
            new_list.push(lst[i]);
            if new_list.len() == 3 {
                return new_list;
            }
        }
        i += 1;
    }
    
    new_list
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 2, 1, 2, 6, 2, 6, 3, 0]), vec![0, 2, 2]);
}
