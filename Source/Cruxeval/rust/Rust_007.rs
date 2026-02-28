fn f(list: Vec<isize>) -> Vec<isize> {
    let mut original = list.clone();
    let mut list = list;
    while list.len() > 1 {
        list.pop();
        for i in (0..list.len()).rev() {
            list.remove(i);
        }
    }
    list = original.clone();
    if let Some(removed_element) = list.pop() {
        println!("{}", removed_element);
    }
    list
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
