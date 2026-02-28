fn f(arr: Vec<isize>) -> Vec<isize> {
    let n: Vec<isize> = arr.iter().cloned().filter(|&item| item % 2 == 0).collect();
    let mut m = n.clone();
    m.extend_from_slice(&arr);
    let len_n = n.len();
    let mut i = 0;
    
    while i < m.len() {
        if m.iter().position(|&x| x == m[i]).unwrap_or(0) >= len_n {
            m.remove(i);
        } else {
            i += 1;
        }
    }
    
    m
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![3, 6, 4, -2, 5]), vec![6, 4, -2, 6, 4, -2]);
}
