fn f(array: Vec<isize>, elem: isize) -> isize {
    let mut elem_str = elem.to_string();
    let mut d = 0;
    
    for i in array.iter() {
        if i.to_string() == elem_str {
            d += 1;
        }
    }
    
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-1, 2, 1, -8, -8, 2], 2), 2);
}
